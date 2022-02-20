#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable az`; then
    az upgrade
else
    brew install azure-cli
fi

brew tap azure/functions
brew install azure-functions-core-tools@4
