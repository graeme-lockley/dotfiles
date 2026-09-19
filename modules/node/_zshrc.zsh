if [[ "$(uname -p)" == "arm" ]]; then
    export PATH="/opt/homebrew/opt/node/bin:$PATH"
else
    export PATH="/usr/local/opt/node/bin:$PATH"
fi
