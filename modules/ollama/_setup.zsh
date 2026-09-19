#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

logging_info "Bundle $DOTFILES_HOME/modules/ollama/Brewfile"
brew bundle --file="$DOTFILES_HOME/modules/ollama/Brewfile"

if pgrep -af 'ollama serve' >/dev/null 2>&1; then
    logging_info "Stopping manually started Ollama processes"
    pkill -f 'ollama serve' || true
    sleep 1
fi

logging_info "Starting Ollama via Homebrew services"
brew services start ollama
