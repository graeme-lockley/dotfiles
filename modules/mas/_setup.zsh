#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

# App Store apps are upgraded here rather than through `brew bundle`, for one
# reason: friction.  mas needs root, so the whole design is about paying for the
# password as few times as possible.
#
#   1. Nothing outdated   -> no password at all.  This is the common case.
#   2. Something outdated -> one `sudo` for the entire batch, not one per app.
#   3. Declared but not installed -> never a silent failure.  mas cannot install
#      an app the account has not already "got", so we say so and stop.
#
# `bin/mas-declared` does the resolving and reports state; this script decides
# what to do about it.  The apps come from the machine's install list, so this
# module stays generic: it never needs to know which apps a machine has.

if ! $DOTFILES_HOME/bin/is-executable mas; then
    logging_status "mas: not installed yet - run dotfiles setup again"
    exit 0
fi

typeset -a upgrade_ids
upgrade_ids=()

while IFS=$'\t' read -r state name id; do
    case "$state" in
    outdated)
        upgrade_ids+=("$id")
        logging_info "mas: $name has an update"
        ;;
    missing)
        logging_status "mas: $name is declared but not installed"
        logging_status "mas:   install it once by hand and re-run setup: mas install $id"
        ;;
    unknown)
        logging_status "mas: $name is declared but no id could be resolved"
        logging_status "mas:   install it once by hand (App Store, or 'mas search $name')"
        ;;
    esac
done < <($DOTFILES_HOME/bin/mas-declared)

if (( ${#upgrade_ids} == 0 )); then
    logging_info "mas: nothing to upgrade"
    exit 0
fi

# Deliberately non-fatal: an App Store hiccup must not abandon the modules that
# have not run yet.  `dotfiles setup` continues either way.
logging_info "mas: upgrading ${#upgrade_ids} app(s) - one password prompt for the batch"
sudo mas upgrade "${upgrade_ids[@]}" ||
    logging_status "mas: upgrade failed - re-run, or upgrade via the App Store"
