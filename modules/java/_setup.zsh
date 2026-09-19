if brew list --formula openjdk >/dev/null 2>&1; then
    brew upgrade openjdk
else
    brew install openjdk
fi

brew install gradle
brew install maven

sudo ln -sfn "$(brew --prefix openjdk)/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk.jdk

for old_jdk in /Library/Java/JavaVirtualMachines/openjdk-*.jdk; do
    [[ -e "$old_jdk" ]] || continue

    target="$(readlink "$old_jdk" 2>/dev/null || true)"
    if [[ "$target" == /opt/homebrew/opt/openjdk@*/libexec/openjdk.jdk ]]; then
        sudo rm "$old_jdk"
    fi
done
