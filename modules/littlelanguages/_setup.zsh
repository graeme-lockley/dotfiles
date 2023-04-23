#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

logging_info "Bundle $DOTFILES_HOME/modules/visual-studio-code/Brewfile"

if test -f ~/.ll/bin/ll
then
  logging_info "Updating littlelanguages"
  ~/.ll/bin/ll setup
else
  logging_info "Installing littlelanguages from scratch"
  deno run --allow-all --reload https://raw.githubusercontent.com/littlelanguages/ll/main/setup.ts
fi

