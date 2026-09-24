if brew list --formula openjdk >/dev/null 2>&1; then
    brew upgrade openjdk
else
    brew install openjdk
fi

brew install gradle

sudo ln -sfn "$(brew --prefix openjdk)/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk.jdk

for old_jdk in /Library/Java/JavaVirtualMachines/openjdk-*.jdk; do
    # -L, not -e: a *dangling* symlink is exactly what a removed version leaves
    # behind, and -e follows the link, so -e skipped the one case this loop
    # exists to clean up - which is how openjdk-23.jdk survived the loop that
    # was written to delete it.
    [[ -L "$old_jdk" ]] || continue

    target="$(readlink "$old_jdk" 2>/dev/null || true)"
    if [[ "$target" == /opt/homebrew/opt/openjdk@*/libexec/openjdk.jdk ]]; then
        sudo rm "$old_jdk"
    fi
done
