export DOTFILES_HOME=~/.dotfiles

export PERSONALITY=home

function logging_debug() {
    if [[ "$DOTFILES_VERBOSE" -eq "2" ]]; then
        echo "Debug: $*"
    fi
}

function logging_info() {
    if [[ "$DOTFILES_VERBOSE" -eq "1" || "$DOTFILES_VERBOSE" -eq "2" ]]; then
        echo "Info: $*"
    fi
}

function logging_status() {
    echo "Status: $*"
}

function logging_error() {
    echo "Error: $*"
    exit 1
}

DOTFILE_SETTINGS_FILE_NAME="$DOTFILES_HOME/settings/_$(uname -n).zsh"
if [[ ! -r "$DOTFILE_SETTINGS_FILE_NAME" ]]; then
    logging_debug "Not found: $DOTFILE_SETTINGS_FILE_NAME"

    DOTFILE_SETTINGS_FILE_NAME="$DOTFILES_HOME/settings/_${PERSONALITY}-setup.zsh"

    if [[ ! -r "$DOTFILE_SETTINGS_FILE_NAME" ]]; then
        logging_debug "Not found: $DOTFILE_SETTINGS_FILE_NAME"
    fi
fi

logging_debug "Using: $DOTFILE_SETTINGS_FILE_NAME"
. $DOTFILE_SETTINGS_FILE_NAME
