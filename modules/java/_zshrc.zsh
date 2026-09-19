typeset -g _java_home_candidate="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

if [[ -d "$_java_home_candidate" ]]; then
    export JAVA_HOME="$_java_home_candidate"
else
    export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
fi

export PATH="$JAVA_HOME/bin:$PATH"
unset _java_home_candidate
