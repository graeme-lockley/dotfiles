#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

logging_info "Bundle $DOTFILES_HOME/modules/visual-studio-code/Brewfile"
brew bundle --file="$DOTFILES_HOME/modules/visual-studio-code/Brewfile"

code --force --install-extension ms-vscode-remote.remote-containers
code --force --install-extension ms-dotnettools.csharp
code --force --install-extension ms-azuretools.vscode-azurefunctions
code --force --install-extension ms-azuretools.vscode-bicep
code --force --install-extension ms-azuretools.vscode-docker

code --force --install-extension ionide.ionide-fsharp
code --force --install-extension foxundermoon.shell-format
code --force --install-extension streetsidesoftware.code-spell-checker

code --force --install-extension ms-vscode.vscode-typescript-next
code --force --install-extension rbbit.typescript-hero

code --force --install-extension svelte.svelte-vscode

code --force --install-extension jebbs.plantuml

code --force --install-extension rust-lang.rust-analyzer
