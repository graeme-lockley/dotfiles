#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

logging_info "Bundle $DOTFILES_HOME/modules/visual studio code/Brewfile"
brew bundle --file="$DOTFILES_HOME/modules/visual studio code/Brewfile"

code --force --install-extension ms-vscode-remote.remote-containers
code --force --install-extension ms-azuretools.vscode-docker
code --force --install-extension coenraads.bracket-pair-colorizer-2
code --force --install-extension ionide.ionide-fsharp
code --force --install-extension foxundermoon.shell-format
