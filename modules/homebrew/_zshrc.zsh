if [[ "$(uname -p)" -eq "arm" ]]; then
    export HOMEBREW_CELLAR=/opt/homebrew/Cellar
    export HOMEBREW_PREFIX=/opt/homebrew
    export HOMEBREW_REPOSITORY=/opt/homebrew
else
    export HOMEBREW_CELLAR=/usr/local/Cellar
    export HOMEBREW_PREFIX=/usr/local
    export HOMEBREW_REPOSITORY=/usr/local
fi

export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH
