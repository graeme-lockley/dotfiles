#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

mkdir -p ~/.config
mkdir -p $DOTFILES_HOME/modules/git/git

sed "s/EMAILADDRESS/$EMAIL_ADDRESS/g" $DOTFILES_HOME/modules/git/config.template  > $DOTFILES_HOME/modules/git/git/config
cp $DOTFILES_HOME/modules/git/ignore $DOTFILES_HOME/modules/git/git/ignore

ln -s -f $DOTFILES_HOME/modules/git/git ~/.config

logging_info "Bundle $DOTFILES_HOME/modules/git/Brewfile"
brew bundle --file=$DOTFILES_HOME/modules/git/Brewfile