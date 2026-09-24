. $DOTFILES_HOME/settings/_home-setup.zsh

# The App Store apps for this machine, managed by mas (see modules/mas).
#
# An App Store app is not something to be configured, it is a line in what this
# one machine should have - so it belongs here, in the machine's install list,
# rather than in a module or in a shared personality file.  A name on its own is
# enough: the id is resolved from `mas list` once the app is installed, so there
# is nothing to look up.  Append an id only to pin one:
#
#     DOTFILES_APPSTORE+=( Xcode 497799835 )
#
# A name containing a space must be quoted, or zsh reads it as two apps.
DOTFILES_APPSTORE=(
)
