#!/bin/zsh

if brew list --formula node >/dev/null 2>&1; then
    brew upgrade node
else
    brew install node
fi

npm install -g npm
