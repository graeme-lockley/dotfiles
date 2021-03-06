#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

if `$DOTFILES_HOME/bin/is-executable brew`; then
    if [[ "$(uname -p)" -eq "arm" ]]; then
        echo "homebrew:     ARM hardware"
    else
        echo "homebrew:     Intel hardware"
    fi
else
    echo "homebrew:     Not installed"
fi
