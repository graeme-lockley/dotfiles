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

## See also

- [The ZShell Manual](https://zsh.sourceforge.io/Doc/Release/zsh_toc.html) because `zsh` is awesome and powerful and misunderstood - *what do you mean my Ferrari has more than 1 gear - WOW!*
- [oh my zsh](https://ohmyz.sh) for when I am impatient and I just want it to work