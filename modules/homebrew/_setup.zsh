#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

if `$DOTFILES_HOME/bin/is-executable brew`; then
    logging_info "update brew"
    brew update

    # The inventory lives with the module that owns the brew lifecycle, so that
    # "what should be installed" is one diffable file.  Entries marked
    # `trusted: true` apply tap trust before anything is loaded.
    BREWFILE_NAME="$DOTFILES_HOME/modules/homebrew/Brewfile"
    logging_info "Bundle $BREWFILE_NAME"
    # Deliberately non-fatal: one unavailable entry (for example a tap formula
    # with no bottle while the Command Line Tools are behind the OS - Homebrew
    # builds those from source and refuses) must not abort the whole setup.
    brew bundle install --file="$BREWFILE_NAME" ||
        logging_status "homebrew: bundle install incomplete - see the errors above"

    logging_info "upgrade brew"
    brew upgrade

    logging_info "remove unused dependencies"
    brew autoremove

    # `--prune=all -s` matters.  A bare `brew cleanup` keeps a cached download
    # for every installed version, which is how the cache grew to 8.8GB.
    logging_info "cleanup brew"
    brew cleanup --prune=all -s
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Now that homebrew has been installed - the script is exiting and you need to rerun dotfiles setup"
    exit 2
fi
