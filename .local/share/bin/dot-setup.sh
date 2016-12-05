#!/bin/bash
#
# This script should be idempotent
set -xeuo pipefail
IFS=$'\n\t'

# Ask for the administrator password upfront
sudo -v

# Keep-alive by updating existing `sudo` timestamp until script finishes
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

chmod 0700 "$HOME/.ssh/"
find "$HOME/.ssh/" -maxdepth 0 -type f ! -name "*.pub" -exec chmod 0600 {} ';'
find "$HOME/.ssh/" -maxdepth 0 -type f -name "*.pub" -exec chmod 0644 {} ';'

mkdir -p "$HOME/.config/" "$HOME/.local/share/bin/"

if [[ ! -f "$HOME/.config/Brewfile" ]]; then
  git --git-dir="$HOME/.local/share/dotfiles/" --work-tree="$HOME" checkout -- "$HOME/.config/Brewfile"
fi

brew bundle --file="$HOME/.config/Brewfile"
brew update && brew upgrade -y && brew cu

FISH=$(which fish)

if ! grep -qF "$FISH" /etc/shells; then
  echo "$FISH" | sudo tee -a /etc/shells > /dev/null
fi

if [[ "$SHELL" != "$FISH" ]]; then
  chsh -s "$FISH"
fi

# install fisherman
#   https://github.com/fisherman/fisherman
if [[ ! -f "$HOME/.config/fish/functions/fisher.fish" ]]; then
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fi

# install oh-my-fish
#   https://github.com/oh-my-fish/oh-my-fish
if [[ "$OMF_PATH" != "$HOME/.local/share/omf" ]]; then
  curl -L http://get.oh-my.fish | fish
fi

brew cleanup
brew cask cleanup

rm -rf "$HOME/.bash_history" "$HOME/.bash_sessions" "$HOME/.subversion/"

if [[ ! -f "$HOME/.config/Homebrew.terminal" ]]; then
  git --git-dir="$HOME/.local/shared/dotfiles" --work-tree="$HOME" checkout -- "$HOME/.config/Homebrew.terminal"
fi
