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
if [[ ! -d "$HOME/.android" ]]; then
  mkdir "$HOME/.android"
fi
link "$HOME/.config/android/adbkey.pub" "$HOME/.android/adbkey.pub"
link "$HOME/.config/ack/ackrc" "$HOME/.ackrc"
if [[ ! -d "$HOME/.atom" ]]; then
  mkdir "$HOME/.atom"
fi
link "$HOME/.config/atom/config.cson" "$HOME/.atom/config.cson"
link "$HOME/.config/atom/init.coffee" "$HOME/.atom/init.coffee"
link "$HOME/.config/atom/keymap.cson" "$HOME/.atom/keymap.cson"
link "$HOME/.config/atom/projects.cson" "$HOME/.atom/projects.cson"
link "$HOME/.config/atom/snippets.cson" "$HOME/.atom/snippets.cson"
link "$HOME/.config/atom/styles.less" "$HOME/.atom/styles.less"
if [[ -d "$HOME/.cups" ]]; then
  mkdir "$HOME/.cups"
fi
link "$HOME/.config/cups/lpoptions" "$HOME/.cups/lpoptions"
link "$HOME/.config/editorconfig/editorconfig" "$HOME/.editorconfig"
link "$HOME/.config/gem/gemrc" "$HOME/.gemrc"
link "$HOME/.config/git/config" "$HOME/.gitconfig"
link "$HOME/.config/git/ignore" "$HOME/.gitignore"
link "$HOME/.config/htmlhint/htmlhintrc" "$HOME/.htmlhintrc"
if [[ -d "$HOME/.jspm" ]]; then
  mkdir "$HOME/.jspm"
fi
link "$HOME/.config/jspm/config" "$HOME/.jspm/config"
if [[ -d "$HOME/.pnpm" ]]; then
  mkdir "$HOME/.pnpm"
fi
link "$HOME/.config/pnpm/package.json" "$HOME/.pnpm/package.json"
link "$HOME/.config/rbenv-gemsets/rbenv-gemsets" "$HOME/.rbenv-gemsets"
link "$HOME/.config/rdebug/rdebugrc" "$HOME/.rdebugrc"
link "$HOME/.config/rspec/rspec" "$HOME/.rspec"
link "$HOME/.config/ruby/ruby-version" "$HOME/.ruby-version"
link "$HOME/.config/sass-lint/sass-lint.yml" "$HOME/.sass-lint.yml"
link "$HOME/.config/screen/screenrc" "$HOME/.screenrc"
link "$HOME/.config/scss-lint/scss-lint.yml" "$HOME/.scss-lint.yml"
link "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
link "$HOME/.config/vim/viminfo" "$HOME/.viminfo"
if [[ -d "$HOME/.virtualenvs" ]]; then
  mkdir "$HOME/.virtualenvs"
fi
link "$HOME/.config/virtualenvs/get_env_details" "$HOME/.virtualenvs/get_env_details"
link "$HOME/.config/virtualenvs/initialize" "$HOME/.virtualenvs/initialize"
link "$HOME/.config/virtualenvs/postactivate" "$HOME/.virtualenvs/postactivate"
link "$HOME/.config/virtualenvs/postdeactive" "$HOME/.virtualenvs/postdeactive"
link "$HOME/.config/virtualenvs/postmkproject" "$HOME/.virtualenvs/postmkproject"
link "$HOME/.config/virtualenvs/postmkvirtualenv" "$HOME/.virtualenvs/postmkvirtualenv"
link "$HOME/.config/virtualenvs/postrmvirtualenv" "$HOME/.virtualenvs/postrmvirtualenv"
link "$HOME/.config/virtualenvs/preactivate" "$HOME/.virtualenvs/preactivate"
link "$HOME/.config/virtualenvs/predeactivate" "$HOME/.virtualenvs/predeactivate"
link "$HOME/.config/virtualenvs/premkproject" "$HOME/.virtualenvs/premkproject"
link "$HOME/.config/virtualenvs/premkvirtualenv" "$HOME/.virtualenvs/premkvirtualenv"
link "$HOME/.config/virtualenvs/prermvirtualenv" "$HOME/.virtualenvs/prermvirtualenv"
ln -s "$HOME/.local/share/z/.z" "$HOME/.z"
