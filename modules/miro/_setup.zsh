#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

logging_info "Bundle $DOTFILES_HOME/modules/miro/Brewfile"
brew bundle --file=$DOTFILES_HOME/modules/miro/Brewfile