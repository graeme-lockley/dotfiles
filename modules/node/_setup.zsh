#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable npm`; then
    npm install -g npm
else
    brew install node@14
fi
