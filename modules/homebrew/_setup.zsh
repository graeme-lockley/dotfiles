#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

if [[ ! $($DOTFILES_HOME/bin/is-executable brew) ]]; then
    brew update
    brew upgrade
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Now that homebrew has been installed - the script is exiting and you need to rerun dotfiles setup"
    exit 2
fi
