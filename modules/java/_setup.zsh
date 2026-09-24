#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

# Homebrew cannot set JAVA_HOME and macOS cannot find a keg-only JDK, so these
# two symlinks are the whole job of this module.  The packages themselves are
# declared elsewhere - openjdk in the machine's Homebrew inventory (see
# modules/homebrew/Brewfile) and gradle in modules/gradle - and both are bundled
# before this runs, so there is nothing to install here.
#
# Everything below lives in a root-owned directory and therefore costs a
# password, which is why stale links are collected first and removed in a single
# call rather than one `sudo` per link.

typeset OPENJDK_LINK=/Library/Java/JavaVirtualMachines/openjdk.jdk
typeset OPENJDK_HOME="$(brew --prefix openjdk 2>/dev/null)/libexec/openjdk.jdk"

# A dangling link here would be worse than no link: java_home would advertise a
# JDK that does not exist.
if [[ ! -e "$OPENJDK_HOME" ]]; then
    logging_error "java: openjdk is not installed - it is declared in modules/homebrew/Brewfile, so re-run dotfiles setup"
fi

# The JDK that java_home and /usr/bin/java should find.
sudo ln -sfn "$OPENJDK_HOME" "$OPENJDK_LINK"

# Links left behind by versions since removed.  A dangling symlink is exactly
# what a removed version leaves, and `-L` is the test for one: `-e` follows the
# link, so it skipped the very case this loop exists to clean up - which is how
# openjdk-23.jdk survived the loop written to delete it.
typeset -a stale_links
stale_links=()

for old_link in /Library/Java/JavaVirtualMachines/openjdk-*.jdk; do
    [[ -L "$old_link" ]] || continue

    target="$(readlink "$old_link" 2>/dev/null || true)"
    if [[ "$target" == /opt/homebrew/opt/openjdk@*/libexec/openjdk.jdk ]]; then
        stale_links+=("$old_link")
    fi
done

if (( ${#stale_links} )); then
    logging_info "java: removing ${#stale_links} stale JVM link(s): ${stale_links[*]}"
    sudo rm "${stale_links[@]}"
fi
