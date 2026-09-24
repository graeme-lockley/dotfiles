#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

# Report App Store drift in the same shape as the Homebrew inventory: what is
# declared but not satisfied.  Deliberately reports rather than acts, because
# acting costs a password and `dotfiles info` should never ask for one.

if ! $DOTFILES_HOME/bin/is-executable mas; then
    echo "mas:          Not installed"
    return
fi

typeset -a outdated missing unknown
outdated=()
missing=()
unknown=()

while IFS=$'\t' read -r state name id; do
    case "$state" in
    outdated) outdated+=("$name") ;;
    missing) missing+=("$name - install once: mas install $id") ;;
    unknown) unknown+=("$name - no id resolved; install once, then re-run") ;;
    esac
done < <($DOTFILES_HOME/bin/mas-declared)

if (( ${#outdated} == 0 && ${#missing} == 0 && ${#unknown} == 0 )); then
    echo "mas:          declared App Store apps satisfied"
    return
fi

if (( ${#outdated} )); then
    echo "${DOTFILES_RED}mas:          installed but outdated${DOTFILES_NOCOLOUR} - run: dotfiles setup"
    printf '                  %s\n' "${outdated[@]}"
fi

if (( ${#missing} )); then
    echo "${DOTFILES_RED}mas:          declared but not installed${DOTFILES_NOCOLOUR}"
    printf '                  %s\n' "${missing[@]}"
fi

if (( ${#unknown} )); then
    echo "${DOTFILES_RED}mas:          declared but id unresolved${DOTFILES_NOCOLOUR}"
    printf '                  %s\n' "${unknown[@]}"
fi
