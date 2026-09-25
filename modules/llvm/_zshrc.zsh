# Homebrew keeps llvm keg-only, so it does not shadow the Command Line Tools
# clang.  This module is the opt-in: clang, clang++, llvm-config, opt and llc
# resolve to Homebrew's build rather than /usr/bin/clang.
typeset -g _llvm_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/llvm"

export PATH="$_llvm_prefix/bin:$PATH"

# Headers and libraries for anything built against LLVM.  Appended rather than
# assigned so another module's flags are not silently replaced.
export CPPFLAGS="-I$_llvm_prefix/include${CPPFLAGS:+ $CPPFLAGS}"
export LDFLAGS="-L$_llvm_prefix/lib${LDFLAGS:+ $LDFLAGS}"

unset _llvm_prefix
