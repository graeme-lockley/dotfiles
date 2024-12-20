# The default personality is home setup.  This setting can then be used by all 
# scripts to ensure a context aware setup.
export DOTFILES_PERSONALITY=home
export EMAIL_ADDRESS=graeme.lockley@gmail.com

export DOTFILES_MODULES=(
    zsh
    homebrew

    git
    entr

    java
    
    deno
    node
    zig

    better-npm-audit
    llvm
    littlelanguages
    markdownlint-cli
    pnpm
    rush
    rust-lang
    shellcheck

    visual-studio-code
    microsoft-edge
    intellij
)
