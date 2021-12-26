#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable npm`; then
    if `$DOTFILES_HOME/bin/is-executable pnpm`; then
        npm install -g npm
    else
        npm install -g pnpm
    fi
else
    logging_error "pnpm: needs npm to be executable"
    exit 2
fi
