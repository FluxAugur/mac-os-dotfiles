#!/usr/bin/env bash
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

chmod 0700 "$HOME/.private"
find "$HOME/.private/" -maxdepth 2 -type d -exec chmod 0700 {} ';'
find "$HOME/.private/" -maxdepth 3 -type f ! -name "*.pub" -exec chmod 0600 {} ';'
find "$HOME/.private/" -maxdepth 3 -type f -name "*.pub" -exec chmod 0644 {} ';'

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

# link configs and other dotfiles to home directory
ln -f "$HOME/.config/android/adbkey.pub" "$HOME/.android/adbkey.pub"
ln -f "$HOME/.config/ack/ackrc" "$HOME/.ackrc"
ln -f "$HOME/.config/atom/config.cson" "$HOME/.atom/config.cson"
ln -f "$HOME/.config/atom/init.coffee" "$HOME/.atom/init.coffee"
ln -f "$HOME/.config/atom/keymap.cson" "$HOME/.atom/keymap.cson"
ln -f "$HOME/.config/atom/projects.cson" "$HOME/.atom/projects.cson"
ln -f "$HOME/.config/atom/snippets.cson" "$HOME/.atom/snippets.cson"
ln -f "$HOME/.config/atom/styles.less" "$HOME/.atom/styles.less"
ln -f "$HOME/.config/cups/lpoptions" "$HOME/.cups/lpoptions"
ln -f "$HOME/.config/editorconfig/editorconfig" "$HOME/.editorconfig"
ln -f "$HOME/.config/gem/gemrc" "$HOME/.gemrc"
ln -f "$HOME/.config/git/config" "$HOME/.gitconfig"
ln -f "$HOME/.config/git/ignore" "$HOME/.gitignore"
ln -f "$HOME/.config/htmlhint/htmlhintrc" "$HOME/.htmlhintrc"
ln -f "$HOME/.config/jspm/config" "$HOME/.jspm/config"
ln -f "$HOME/.config/pnpm/package.json" "$HOME/.pnpm/package.json"
ln -f "$HOME/.config/rbenv/default-gems" "$HOME/.rbenv/default-gems"
ln -f "$HOME/.config/rbenv/version" "$HOME/.rbenv/version"
ln -f "$HOME/.config/rbenv/version" "$HOME/.config/ruby/ruby-version"
ln -f "$HOME/.config/rbenv-gemsets/rbenv-gemsets" "$HOME/.rbenv-gemsets"
ln -f "$HOME/.config/rdebug/rdebugrc" "$HOME/.rdebugrc"
ln -f "$HOME/.config/rspec/rspec" "$HOME/.rspec"
ln -f "$HOME/.config/ruby/ruby-version" "$HOME/.ruby-version"
ln -f "$HOME/.config/sass-lint/sass-lint.yml" "$HOME/.sass-lint.yml"
ln -f "$HOME/.config/screen/screenrc" "$HOME/.screenrc"
ln -f "$HOME/.config/scss-lint/scss-lint.yml" "$HOME/.scss-lint.yml"
ln -f "$HOME/.config/ssh/id_rsa.pub" "$HOME/.ssh/id_rsa.pub"
ln -f "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -f "$HOME/.config/vim/viminfo" "$HOME/.viminfo"
ln -f "$HOME/.local/share/z/.z" "$HOME/.z"

hln "$HOME/.config/virtualenvs/" "$HOME/.virtualenvs"

# private links
ln -f "$HOME/.private/keys/android/adbkey" "$HOME/.android/adbkey"
ln -f "$HOME/.private/keys/ssh/id_rsa" "$HOME/.ssh/id_rsa"
ln -f "$HOME/.private/ssh/known_hosts" "$HOME/.ssh/known_hosts"

hln "$HOME/.private/gnupg/" "$HOME/.gnupg"
