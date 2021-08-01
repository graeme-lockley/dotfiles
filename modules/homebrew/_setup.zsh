#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

if `$DOTFILES_HOME/bin/is-executable brew`; then
    logging_info "update brew"
    brew update

    logging_info "upgrade brew"
    brew upgrade

    logging_info "cleanup brew"
    brew cleanup
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Now that homebrew has been installed - the script is exiting and you need to rerun dotfiles setup"
    exit 2
fi
