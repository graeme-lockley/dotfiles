#!/bin/zsh

brew tap azure/functions
brew install azure-functions-core-tools@4

brew tap azure/bicep
if brew list --formula bicep >/dev/null 2>&1; then
    brew upgrade bicep
else
    brew install bicep
fi
