function update-all -d "Update macOS software, Homebrew brews & casks, gems, packages (apms, npms), repos"
  # macOS software updates
  command update-os
  # Homebrew brews updates
  command update-brews
  # Homebrew cask updates
  command update-casks
  # NPM updates
  command update-npms


end
