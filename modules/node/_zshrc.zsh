if [[ "$(uname -p)" == "arm" ]]; then
    export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
else
    export PATH="/usr/local/opt/node@14/bin:$PATH"
fi

