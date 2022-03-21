#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable az`; then
    az upgrade
    az bicep upgrade
else
    brew install azure-cli
fi

brew tap azure/functions
brew install azure-functions-core-tools@4

brew tap azure/bicep
brew install bicep
