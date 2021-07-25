#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

if [[ ! $($DOTFILES_HOME/bin/is-executable brew) ]]; then
    echo "homebrew:     Not installed"
elif [[ "$(uname -p)" -eq "arm" ]]; then
    echo "homebrew:     ARM hardware"
else
    echo "homebrew:     Intel hardware"
fi
