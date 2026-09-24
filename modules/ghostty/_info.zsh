#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

# Report whether Ghostty will actually read the config this repo owns.
#
# A symlink on its own is not evidence, because two other things can defeat it:
#
#   1. the symlink is missing, or points somewhere other than the repo
#   2. on macOS Ghostty also reads Application Support/config.ghostty, and that
#      file wins wherever the two disagree - so a stray one silently overrides
#      this config
#
# So the last step asks Ghostty itself.  The config sets a canary that differs
# from Ghostty's default, which means `ghostty +show-config` lists it if and only
# if the file was read.  Comparing the two is proof rather than inference.
#
# Read-only by design: `dotfiles info` should never change anything, and this
# file is also what modules/ghostty/_setup.zsh prints once it has linked.

typeset CONFIG_FILE_NAME=$DOTFILES_HOME/modules/ghostty/config.ghostty
typeset LINK_FILE_NAME=$HOME/.config/ghostty/config.ghostty
typeset MACOS_FILE_NAME="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
typeset CANARY_KEY=font-size

function value_in_config_file() {
    # "key = value" -> "value"; last one wins, as it does in Ghostty.
    grep -E "^${CANARY_KEY}[[:space:]]*=" "$1" 2>/dev/null |
        tail -1 |
        sed -E 's/^[^=]*=[[:space:]]*//; s/[[:space:]]+$//'
}

function value_reported_by_ghostty() {
    ghostty +show-config 2>/dev/null |
        grep -E "^${CANARY_KEY} = " |
        tail -1 |
        sed -E 's/^[^=]*=[[:space:]]*//; s/[[:space:]]+$//'
}

if [[ ! -L "$LINK_FILE_NAME" || "$(readlink "$LINK_FILE_NAME")" != "$CONFIG_FILE_NAME" ]]; then
    echo "${DOTFILES_RED}ghostty:      config NOT linked${DOTFILES_NOCOLOUR} - run: dotfiles setup"
elif [[ -s "$MACOS_FILE_NAME" ]]; then
    echo "${DOTFILES_RED}ghostty:      config overridden${DOTFILES_NOCOLOUR} - Application Support/config.ghostty wins over the repo; delete that file"
elif ! $DOTFILES_HOME/bin/is-executable ghostty; then
    echo "ghostty:      config linked (ghostty not installed yet, so not proven)"
elif ! ghostty +validate-config >/dev/null 2>&1; then
    echo "${DOTFILES_RED}ghostty:      config linked but INVALID${DOTFILES_NOCOLOUR} - run: ghostty +validate-config"
else
    typeset WANTED=$(value_in_config_file "$CONFIG_FILE_NAME")
    typeset REPORTED=$(value_reported_by_ghostty)

    if [[ -z "$WANTED" ]]; then
        echo "ghostty:      config linked and valid (no $CANARY_KEY canary set to prove it is read)"
    elif [[ "$REPORTED" == "$WANTED" ]]; then
        echo "ghostty:      config linked, valid, and read by ghostty ($CANARY_KEY=$REPORTED)"
    else
        echo "${DOTFILES_RED}ghostty:      config linked but NOT read${DOTFILES_NOCOLOUR} - repo says $CANARY_KEY=$WANTED, ghostty reports ${REPORTED:-nothing}"
    fi
fi
