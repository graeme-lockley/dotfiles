JAVA_VERSION=23

brew install openjdk@${JAVA_VERSION}

brew install gradle
brew install maven

sudo ln -sfn /opt/homebrew/opt/openjdk@${JAVA_VERSION}/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-${JAVA_VERSION}.jdk
