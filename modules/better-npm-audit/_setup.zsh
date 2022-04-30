#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable better-npm-audit`; then
    if `$DOTFILES_HOME/bin/is-executable better-npm-audit`; then
        npm update -g better-npm-audit
    else
        npm install -g better-npm-audit
    fi
else
    logging_error "better-npm-audit: needs npm to be executable"
    exit 2
fi
