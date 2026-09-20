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
- **Third-party taps must be trusted, or Homebrew 7 ignores them in silence.**  The failure mode is what makes this worth remembering: `brew outdated` simply reports nothing while you sit several versions behind.  Declare it per formula with `, trusted: true` rather than trusting a whole tap, because whole-tap trust also accepts every future formula that tap ever ships.  `brew bundle install` applies trust before it loads any entry, so a rebuilt machine needs no manual `brew trust` step.
- **`dotfiles info` reports drift in both directions** - declared-but-missing via `brew bundle check`, and installed-but-undeclared via `bin/brew-undeclared`.  Silence from both means the machine matches its declaration.
- **`dotfiles setup` bundles, upgrades, autoremoves, then prunes.**  `brew cleanup --prune=all -s` is deliberate: a bare `brew cleanup` keeps a cached download for every installed version, which is how the cache quietly reached 8.8GB.

Homebrew refuses to install any formula that has no bottle when the Command Line Tools are older than the OS, because those entries get built from source.  That is a hard gate rather than a warning, and there is no bypass short of updating the tools.  `dotfiles setup` reports it and carries on instead of abandoning the remaining modules.

## See also

- [The ZShell Manual](https://zsh.sourceforge.io/Doc/Release/zsh_toc.html) because `zsh` is awesome and powerful and misunderstood - *what do you mean my Ferrari has more than 1 gear - WOW!*
- [oh my zsh](https://ohmyz.sh) for when I am impatient and I just want it to work