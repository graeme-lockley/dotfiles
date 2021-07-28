# LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib -Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib"
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"

export LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/llvm/include"
