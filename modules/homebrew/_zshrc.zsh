if [[ "`uname -p`" -eq "arm" ]]; then
    export HOMEBREW_CELLAR=/opt/homebrew/Cellar
    export HOMEBREW_PREFIX=/opt/homebrew
    export HOMEBREW_REPOSITORY=/opt/homebrew
    export PATH=$~HOMEBREW_PREFIX/bin:$PATH
else
    export HOMEBREW_CELLAR=/usr/local/Cellar
    export HOMEBREW_PREFIX=/usr/local
    export HOMEBREW_REPOSITORY=/usr/local
    export PATH=$~HOMEBREW_PREFIX/bin:$PATH
fi
