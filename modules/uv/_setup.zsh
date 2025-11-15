#!/bin/zsh

if `$DOTFILES_HOME/bin/is-executable specify`; then
    uv tool update specify-cli 
else
    uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
fi
