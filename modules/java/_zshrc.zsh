# The default JDK is the latest openjdk.  modules/java/_setup.zsh registers
# openjdk@21 beside it for Gradle toolchains; reach that one with
# `/usr/libexec/java_home -v 21` rather than changing JAVA_HOME here.
typeset -g _java_home_candidate="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

if [[ -d "$_java_home_candidate" ]]; then
    export JAVA_HOME="$_java_home_candidate"
else
    export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
fi

export PATH="$JAVA_HOME/bin:$PATH"
unset _java_home_candidate
