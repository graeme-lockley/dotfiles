#!/bin/zsh

# Link the shared config into the location Ghostty reads.
#
# `ln -s -f` is the convention used by modules/zsh and modules/git.  It replaces
# an existing symlink, and an existing real file is unlinked first, so a machine
# that has drifted into a hand-edited config is pulled back to the repo.
#
# The directory has to exist first: `ln -s` will not create parents, and the
# config sits two levels down in ~/.config.

mkdir -p ~/.config/ghostty
ln -s -f $DOTFILES_HOME/modules/ghostty/config.ghostty ~/.config/ghostty/config.ghostty
