# dotfiles

My dotfiles - designed for me with minimum of baggage.

The style of this project is a dialogue with my internal self with the purpose:

- Reminding myself the rationale behind decisions, and
- Reminding myself how to use this project

My expectation is that these files will be touched from time-to-time and therefore will be stored in my decaying long-term memory.  So this page is really a substitute for my long-term memory.

If you are reading this and you are not me then feel free to copy my long-term memory adding it into your own experiences.  What I do ask is please copy the code and the techniques but please don't attempt to use this codebase as an attempt to unify all dotfiles in the known universe.  A developer's environment is personal and opinionated needing to navigate the well meant but seemingly madness of corporate information security policies whilst retaining a level of coherency for themselves.

## Assumptions and Decisions

- These dotfiles are primarily for my Mac.  However, sneaky sneaky, a large part of my development is in containers within VSCode running Ubuntu or some other flavour of Linux.  So, priority, is they must setup my Mac experience and then, as a secondary, ensure that the terminal experience in my container is consistent.  Third priority is using in pipelines but, truthfully, I think that is really la la land.
- `zsh` for ever!
- Each machine has a personality - HOME or WORK.  The rationale is these environments are different and require different certificates.
- Each machine can have different settings.  I know that sounds counter intuitive but, wait, when you need it you'll go "ah - wish I could do that - look at how I hacked it to work"
- Each installed application is configured separately - called a module in my parlance.
- `brew` to do all of the heavy lifting.

## Homebrew

`brew` does all of the heavy lifting, so it gets one rule and one inventory.

- **`modules/homebrew/Brewfile` is the inventory of the machine** - the complete list of what should be installed.  A module owns an application and its config; this file owns the brew state of the machine, so there is exactly one place to diff and exactly one place to check.  Module Brewfiles may repeat entries here; `brew bundle` is idempotent.
- **Regenerate it from reality** with `brew bundle dump --force --file=~/.dotfiles/modules/homebrew/Brewfile`, then re-apply the lines marked `DECISION` and diff before committing.  The file is a curated snapshot, not something to type from scratch.
- **Third-party taps must be trusted, or Homebrew 7 ignores them in silence.**  The failure mode is what makes this worth remembering: `brew outdated` simply reports nothing while you sit several versions behind.  Declare it per formula with `, trusted: true` rather than trusting a whole tap, because whole-tap trust also accepts every future formula that tap ever ships.  `brew bundle install` applies trust before it loads any entry, so a rebuilt machine needs no manual `brew trust` step.  The store lives outside the repo, so `dotfiles info` also reports trust entries that nothing declares - an entry outliving the formula it was granted for is invisible to a diff, and that is exactly how a renamed formula leaves residue behind.
- **`dotfiles info` reports drift in both directions** - declared-but-missing via `brew bundle check`, and installed-but-undeclared via `bin/brew-undeclared`.  Silence from both means the machine matches its declaration.
- **`dotfiles setup` bundles, upgrades, autoremoves, then prunes.**  `brew cleanup --prune=all -s` is deliberate: a bare `brew cleanup` keeps a cached download for every installed version, which is how the cache quietly reached 8.8GB.

Homebrew refuses to install any formula that has no bottle when the Command Line Tools are older than the OS, because those entries get built from source.  That is a hard gate rather than a warning, and there is no bypass short of updating the tools.  `dotfiles setup` reports it and carries on instead of abandoning the remaining modules.

## App Store

`mas` is brew's counterpart for the App Store, and it needs root - so the whole design here is about paying for a password as few times as possible.

- **The machine's install list declares its App Store apps**, in `settings/_<machine>.zsh`:

      DOTFILES_APPSTORE=( Slack Telegram )

  An App Store app is not an application to be configured, it is a line in what a single machine should have, so it belongs with the modules that machine enables rather than beside them.  `modules/mas` owns the mechanism and never needs to know which apps any machine has.
- **The id is optional.**  It is the annoying thing to look up, so it is resolved from `mas list` - local, no network, no password - for apps that are already installed.  Install once by hand, declare it by name, and then never look the id up again.  An id may be appended to pin one.
- **Nothing to upgrade means no password at all.**  `dotfiles setup` reaches `sudo` only when something is genuinely out of date, and then upgrades every outdated app in a single call rather than one call per app.
- **`mas` cannot install an app the account has not already "got"**, so a declared-but-absent app is never a silent failure.  Setup names it and gives the one command to run by hand; silence there would mean the machine quietly differed from its declaration.
- **`dotfiles info` reports drift but never prompts.**  Reporting and acting are deliberately separated, so asking about the state of the machine never costs a password.
- **This is not done through `brew bundle`.**  Homebrew's own `mas "Name", id: N` entries look like the answer, but the id must be an integer, so brew can never work one out for you, and it reaches mas once per entry.  `bin/mas-declared` is the glue that resolves ids locally, reports state, and lets the two callers do the right thing - one reports, the other batches.
- **The App Store updates itself anyway**, so this is a nudge rather than the only route: Slack and Telegram were quietly brought up to date in the background once already, between two runs of the same command.

## Root and sudo

Two modules need root: `mas` (App Store upgrades) and `java` (the JVM symlinks in `/Library/Java/JavaVirtualMachines`).  Both are built to pay for the password as little as possible, and `dotfiles setup` ties them together so the whole run costs at most one prompt.

- **A settled machine costs no password at all.**  The java module repairs only links that are actually wrong, so once `openjdk.jdk` and `openjdk-21.jdk` point where they should it runs no `sudo`; the mas module reaches `sudo` only when an app is genuinely out of date.  This is the common case.
- **One password covers the whole run when root is needed.**  sudo caches a credential per terminal for five minutes (`timestamp_timeout`), and `brew upgrade` alone can outlast that - which is why the password was asked for again part-way through.  `dotfiles setup` refreshes the cached ticket in the background once it exists.  The refresh uses `sudo -n`, which never prompts, so a run that needs no root still asks for nothing: until the first module authenticates, the loop fails in silence.  A trap kills it on exit, interrupt or termination.
- **Each module batches its own root work.**  java collects every `ln` and `rm` into a single root shell rather than one `sudo` per link; mas upgrades every outdated app in one call.  The keep-alive is what makes those batches add up to one prompt instead of several.

## See also

- [The ZShell Manual](https://zsh.sourceforge.io/Doc/Release/zsh_toc.html) because `zsh` is awesome and powerful and misunderstood - *what do you mean my Ferrari has more than 1 gear - WOW!*
- [oh my zsh](https://ohmyz.sh) for when I am impatient and I just want it to work