function update-all -d "Update macOS software, Homebrew brews & casks, gems, packages (apms, npms), repos"
  # Ask for the administrator password upfront
  sudo -v
  # macOS & Mac App Store software updates
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
  # Fish completions
  fish_update_completions
end
