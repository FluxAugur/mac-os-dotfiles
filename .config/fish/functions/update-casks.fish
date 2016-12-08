function update-casks -d "Update, upgrade, and cleanup Homebrew casks"
  command brew cask update; and brew cu; and brew cask cleanup; and brew cask doctor
end
