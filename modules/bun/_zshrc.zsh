# Homebrew links the bun binary into $HOMEBREW_PREFIX/bin, so the runtime itself
# needs nothing from here.  Global packages land in $BUN_INSTALL/bin (default
# ~/.bun), which is not on PATH on its own - that is where `bun add -g` puts its
# shims.
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"
