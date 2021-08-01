/^brew/ { system("brew uninstall " $2) }
/^cask/ { system("brew uninstall " $2) }