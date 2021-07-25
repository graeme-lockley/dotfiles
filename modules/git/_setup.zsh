#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

mkdir -p ~/.config

if [[ "$DOTFILES_PERSONALITY" -eq "work" ]]; then
    EMAIL_ADDRESS=graeme.lockley@investec.co.za
else
    EMAIL_ADDRESS=graeme.lockley@gmail.com
fi

sed "s/EMAILADDRESS/$EMAIL_ADDRESS/g" $DOTFILES_HOME/modules/git/config.template  > $DOTFILES_HOME/modules/git/git/config

ln -s -f $DOTFILES_HOME/modules/git/git ~/.config

logging_info "Bundle $DOTFILES_HOME/modules/git/Brewfile"
brew bundle --file=$DOTFILES_HOME/modules/git/Brewfile