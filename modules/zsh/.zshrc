export DOTFILES_VERBOSE=0
. ~/.dotfiles/bin/_env.zsh

export PATH=$PATH:$DOTFILES_HOME/bin

for module in $DOTFILES_MODULES; do
    EXEC_FILE_NAME="$DOTFILES_HOME/modules/$module/_zshrc.zsh"

    if [[ -e "$EXEC_FILE_NAME" ]]; then
        . $EXEC_FILE_NAME
    fi
done
