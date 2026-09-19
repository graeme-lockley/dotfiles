export DOTFILES_VERBOSE=0
. ~/.dotfiles/bin/_env.zsh

export PATH=$PATH:$DOTFILES_HOME/bin

export DOTFILES_RED="\033[1;31m"
export DOTFILES_GREEN="\033[1;32m"
export DOTFILES_NOCOLOUR="\033[0m"

for module in $DOTFILES_MODULES; do
    EXEC_FILE_NAME="$DOTFILES_HOME/modules/$module/_zshrc.zsh"

    if [[ -e "$EXEC_FILE_NAME" ]]; then
        . $EXEC_FILE_NAME
    fi
done

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/graemel/.lmstudio/bin"

# Task Master aliases added on 4/18/2025
alias tm='task-master'
alias taskmaster='task-master'
