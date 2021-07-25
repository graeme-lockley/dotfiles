#!/bin/zsh

mkdir -p ~/.config

if [[ "$DOTFILES_PERSONALITY" -eq "work" ]]; then
    EMAIL_ADDRESS=graeme.lockley@investec.co.za
else
    EMAIL_ADDRESS=graeme.lockley@gmail.com
fi

echo "Home: " $DOTFILES_HOME/modules/git/config.template

sed "s/EMAILADDRESS/$EMAIL_ADDRESS/g" $DOTFILES_HOME/modules/git/config.template  > $DOTFILES_HOME/modules/git/git/config

ln -s -f $DOTFILES_HOME/modules/git/git ~/.config
