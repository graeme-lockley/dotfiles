#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

if `$DOTFILES_HOME/bin/is-executable brew`; then
    if [[ "$(uname -p)" -eq "arm" ]]; then
        echo "homebrew:     $(brew --version | head -1) on ARM hardware"
    else
        echo "homebrew:     $(brew --version | head -1) on Intel hardware"
    fi

    BREWFILE_NAME="$DOTFILES_HOME/modules/homebrew/Brewfile"

    if [[ -e "$BREWFILE_NAME" ]]; then
        if brew bundle check --file="$BREWFILE_NAME" >/dev/null 2>&1; then
            echo "homebrew:     declared inventory satisfied"
        else
            echo "${DOTFILES_RED}homebrew:     declared inventory NOT satisfied${DOTFILES_NOCOLOUR} - run: brew bundle install --file=$BREWFILE_NAME"
        fi
    fi

    # The other direction of drift: something installed that nothing declares,
    # so a rebuilt machine would not have it.  Covers formulae and casks both.
    UNDECLARED_PACKAGES="$($DOTFILES_HOME/bin/brew-undeclared)"
    if [[ -n "$UNDECLARED_PACKAGES" ]]; then
        echo "${DOTFILES_RED}homebrew:     installed but undeclared:${DOTFILES_NOCOLOUR}"
        echo "$UNDECLARED_PACKAGES" | sed 's/^/                  /'
    else
        echo "homebrew:     nothing undeclared"
    fi

    # The third direction: trust granted to something no Brewfile declares.
    # Unlike the two above, a diff cannot show this one going stale, because the
    # store lives outside the repo - an entry simply outlives the formula it was
    # granted for.
    UNDECLARED_TRUST="$($DOTFILES_HOME/bin/brew-trust-undeclared)"
    if [[ -n "$UNDECLARED_TRUST" ]]; then
        echo "${DOTFILES_RED}homebrew:     trusted but undeclared:${DOTFILES_NOCOLOUR}"
        echo "$UNDECLARED_TRUST" | sed 's/^/                  /'
    else
        echo "homebrew:     nothing over-trusted"
    fi
else
    echo "homebrew:     Not installed"
fi
