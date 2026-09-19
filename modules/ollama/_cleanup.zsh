#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

logging_info "Stopping Ollama Homebrew service"
brew services stop ollama || true

logging_info "Removing $DOTFILES_HOME/modules/ollama/Brewfile"
brew-bundle-delete "$DOTFILES_HOME/modules/ollama/Brewfile"
