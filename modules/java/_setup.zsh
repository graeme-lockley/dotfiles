#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

# Homebrew cannot set JAVA_HOME and macOS cannot find a keg-only JDK, so these
# symlinks are the whole job of this module.  The packages themselves are
# declared elsewhere - the JDKs in the machine's Homebrew inventory (see
# modules/homebrew/Brewfile) and gradle in modules/gradle - and all are bundled
# before this runs, so there is nothing to install here.
#
# Two JDKs are registered on purpose.  openjdk (the latest) stays the default,
# because it is what JAVA_HOME and /usr/bin/java find.  openjdk@21 is registered
# beside it so Gradle toolchains resolve locally: java-chat pins
# jvmToolchain(21), and an unregistered JDK 21 is one Gradle downloads for
# itself.
#
# Everything below lives in a root-owned directory and therefore costs a
# password, which is why the links are applied in a single root call rather than
# one `sudo` each.

# link basename -> brew formula.  The basename is how macOS registers the JVM,
# and the plain `openjdk.jdk` name is what makes the latest the default.
typeset -A managed_jdks
managed_jdks=(
    openjdk.jdk    openjdk
    openjdk-21.jdk openjdk@21
)

typeset -a link_commands
link_commands=()

for link_name formula in ${(kv)managed_jdks}; do
    home="$(brew --prefix "$formula" 2>/dev/null)/libexec/openjdk.jdk"

    # A dangling link here would be worse than no link: java_home would
    # advertise a JDK that does not exist.
    if [[ ! -e "$home" ]]; then
        logging_error "java: $formula is not installed - it is declared in modules/homebrew/Brewfile, so re-run dotfiles setup"
    fi

    link_commands+=("ln -sfn '$home' '/Library/Java/JavaVirtualMachines/$link_name'")
done

# `ln` takes one source/target pair, so the commands are joined into a single
# root shell instead of one call each.  The paths are Homebrew's, so there is
# nothing here that needs escaping.
sudo zsh -c "${(j: && :)link_commands}"

# Links left behind by versions since removed.  A dangling symlink is exactly
# what a removed version leaves, and `-L` is the test for one: `-e` follows the
# link, so it skipped the very case this loop exists to clean up - which is how
# openjdk-23.jdk survived the loop written to delete it.  A live link is kept
# only when this module owns it, so a link to a gradle dependency such as
# openjdk@25 does not register a JDK nobody asked for.
typeset brew_opt="$(brew --prefix)/opt"
typeset -a stale_links
stale_links=()

# (N) so an empty directory is not a glob error, which would abort setup on a
# machine that has never had a stale link.
for old_link in /Library/Java/JavaVirtualMachines/openjdk-*.jdk(N); do
    [[ -L "$old_link" ]] || continue

    link_name="${old_link:t}"
    [[ -n "${managed_jdks[$link_name]}" ]] && continue

    target="$(readlink "$old_link" 2>/dev/null || true)"
    if [[ "$target" == "$brew_opt"/openjdk@*/libexec/openjdk.jdk ]]; then
        stale_links+=("$old_link")
    fi
done

if (( ${#stale_links} )); then
    logging_info "java: removing ${#stale_links} stale JVM link(s): ${stale_links[*]}"
    sudo rm "${stale_links[@]}"
fi
