#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

mkdir -p ~/.config

sed "s/EMAILADDRESS/$EMAIL_ADDRESS/g" $DOTFILES_HOME/modules/git/config.template  > $DOTFILES_HOME/modules/git/git/config

mkdir -p $DOTFILES_HOME/modules/git/git
ln -s -f $DOTFILES_HOME/modules/git/git ~/.config

logging_info "Bundle $DOTFILES_HOME/modules/git/Brewfile"
brew bundle --file=$DOTFILES_HOME/modules/git/Brewfile