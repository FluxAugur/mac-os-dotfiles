function update-casks -d "Update, upgrade, and cleanup Homebrew casks"
  command brew cask update; and brew cu -a; and brew cask cleanup;
end
