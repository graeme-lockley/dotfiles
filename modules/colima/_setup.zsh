#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

logging_info "Bundle $DOTFILES_HOME/modules/colima/Brewfile"
brew bundle --file="$DOTFILES_HOME/modules/colima/Brewfile"

if colima status >/dev/null 2>&1; then
    logging_info "Stopping existing Colima instance"
    colima stop
fi

logging_info "Starting Colima with cpu=4 memory=6 disk=40"
colima start --cpu 4 --memory 6 --disk 40
