#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable npm`; then
    npm install -g @microsoft/rush
else
    logging_error "rush: needs npm to be executable"
    exit 2
fi
