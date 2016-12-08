function update-all -d "Update macOS software, Homebrew brews & casks, gems, packages (apms, npms), repos"
  # macOS software updates
  update-os
  # Homebrew brews updates
  update-brews
  # Homebrew cask updates
  update-casks
  # NPM updates
  update-npms
  # Gem updates
  update-gems
  # APM updates
  update-apms
end
