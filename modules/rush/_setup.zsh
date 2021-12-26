#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable npm`; then
    if `$DOTFILES_HOME/bin/is-executable rush`; then
        npm update -g @microsoft/rush
    else
        npm install -g @microsoft/rush
    fi
else
    logging_error "rush: needs npm to be executable"
    exit 2
fi
