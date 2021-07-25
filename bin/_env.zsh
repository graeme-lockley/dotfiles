DOTFILES_HOME=~/.dotfiles

export PERSONALITY=home

function info() {
    if [[ "$DOTFILES_VERBOSE" -eq "1" ]]; then
        echo "Info: $*"
    fi
}

function status() {
    echo "Status: $*"
}

function error() {
    echo "Error: $*"
    exit 1
}

DOTFILE_SETTINGS_FILE_NAME="$DOTFILES_HOME/settings/_$(uname -n).zsh"
if [[ ! -r "$DOTFILE_SETTINGS_FILE_NAME" ]]; then
    info "Not found: $DOTFILE_SETTINGS_FILE_NAME"

    DOTFILE_SETTINGS_FILE_NAME="$DOTFILES_HOME/settings/_${PERSONALITY}-setup.zsh"

    if [[ ! -r "$DOTFILE_SETTINGS_FILE_NAME" ]]; then
        error "Not found: $DOTFILE_SETTINGS_FILE_NAME"
    fi
fi

info "Using: $DOTFILE_SETTINGS_FILE_NAME"
. $DOTFILE_SETTINGS_FILE_NAME
