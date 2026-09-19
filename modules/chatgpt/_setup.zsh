#!/bin/zsh

APP_PATH="/Applications/ChatGPT.app"

if brew list --cask chatgpt >/dev/null 2>&1; then
    if [[ ! -d "$APP_PATH" ]]; then
        brew reinstall --cask --appdir=/Applications chatgpt
    fi
else
    brew install --cask --appdir=/Applications chatgpt
fi
