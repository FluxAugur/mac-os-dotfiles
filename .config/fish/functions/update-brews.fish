function update-brews -d "Update, upgrade, cleanup, prune, and doctor Homebrew brews"
  command brew update; and brew upgrade -y --cleanup; and brew prune; and brew doctor
end
