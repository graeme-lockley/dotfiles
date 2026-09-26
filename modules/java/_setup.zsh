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
# Only a link that is actually wrong is repaired, so on a settled machine this
# module asks for no password at all.  When something does need root, every
# change is applied in a single root call rather than one `sudo` each.

# link basename -> brew formula.  The basename is how macOS registers the JVM,
# and the plain `openjdk.jdk` name is what makes the latest the default.
typeset -A managed_jdks
managed_jdks=(
    openjdk.jdk    openjdk
    openjdk-21.jdk openjdk@21
)

typeset -a root_commands
root_commands=()

for link_name formula in ${(kv)managed_jdks}; do
    home="$(brew --prefix "$formula" 2>/dev/null)/libexec/openjdk.jdk"

    # A dangling link here would be worse than no link: java_home would
    # advertise a JDK that does not exist.
    if [[ ! -e "$home" ]]; then
        logging_error "java: $formula is not installed - it is declared in modules/homebrew/Brewfile, so re-run dotfiles setup"
    fi

    # Nothing to do - and therefore no password - when the link already points
    # where it should.  `home` runs through the formula's `opt` symlink, which
    # is stable across upgrades, so this is the common case.
    link_path="/Library/Java/JavaVirtualMachines/$link_name"
    if [[ "$(readlink "$link_path" 2>/dev/null)" == "$home" ]]; then
        logging_debug "java: $link_name already points at $formula"
        continue
    fi

    root_commands+=("ln -sfn '$home' '$link_path'")
done

# Links left behind by versions since removed.  A dangling symlink is exactly
# what a removed version leaves, and `-L` is the test for one: `-e` follows the
# link, so it skipped the very case this loop exists to clean up - which is how
# openjdk-23.jdk survived the loop written to delete it.  A live link is kept
# only when this module owns it, so a link to a gradle dependency such as
# openjdk@25 does not register a JDK nobody asked for.
typeset brew_opt="$(brew --prefix)/opt"

# (N) so an empty directory is not a glob error, which would abort setup on a
# machine that has never had a stale link.
for old_link in /Library/Java/JavaVirtualMachines/openjdk-*.jdk(N); do
    [[ -L "$old_link" ]] || continue

    link_name="${old_link:t}"
    [[ -n "${managed_jdks[$link_name]}" ]] && continue

    target="$(readlink "$old_link" 2>/dev/null || true)"
    if [[ "$target" == "$brew_opt"/openjdk@*/libexec/openjdk.jdk ]]; then
        root_commands+=("rm '$old_link'")
    fi
done

if (( ${#root_commands} )); then
    logging_info "java: applying ${#root_commands} JVM link change(s)"
    # `ln` and `rm` are collected and handed to a single root shell: one
    # password for the whole module rather than one per link.  The paths are
    # Homebrew's, so nothing here needs escaping.
    sudo zsh -c "${(j: && :)root_commands}"
else
    logging_debug "java: JVM links already correct"
fi
