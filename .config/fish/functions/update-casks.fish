function update-casks -d "Update, upgrade, and cleanup Homebrew casks"
  command brew cask update; and brew cu; and brew cask cleanup; and brew cask doctor
  # Remove duplicates in the “Open With” menu
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
end
