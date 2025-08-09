JAVA_VERSION=21

brew install openjdk@${JAVA_VERSION}
sudo ln -sfn /opt/homebrew/opt/openjdk@${JAVA_VERSION}/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-${JAVA_VERSION}.jdk

brew install gradle
brew install maven

