#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

# Link the shared config into the location Ghostty reads.
#
# `ln -s -f` is the convention used by modules/zsh and modules/git.  It replaces
# an existing symlink, and an existing real file is unlinked first, so a machine
# that drifted into a hand-edited config is pulled back to the repo.
#
# The directory has to exist first: `ln -s` will not create parents.
mkdir -p ~/.config/ghostty
ln -s -f $DOTFILES_HOME/modules/ghostty/config.ghostty ~/.config/ghostty/config.ghostty

# Then prove it rather than assume it.  The whole point of this module is that
# every machine ends up with the same config, and "linked but not read" is the
# failure that would otherwise go unnoticed - so ask Ghostty what it read.  This
# is the same check `dotfiles info` reports.
#
# The cask is declared in modules/homebrew/Brewfile precisely so that ghostty is
# installed before this runs; setup bundles a module's Brewfile only after its
# _setup.zsh, so an app declared here would be too late to verify against.
$DOTFILES_HOME/modules/ghostty/_info.zsh
