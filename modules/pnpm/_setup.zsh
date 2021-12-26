#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable npm`; then
    npm install -g pnpm
else
    logging_error "pnpm: needs npm to be executable"
    exit 2
fi
