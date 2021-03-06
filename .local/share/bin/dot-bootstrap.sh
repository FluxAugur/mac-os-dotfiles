#!/usr/bin/env bash
#
# This script is not idempotent. Be careful!
set -euo pipefail
IFS=$'\n\t'

LOCAL_REPO=$HOME/.local/share/dotfiles/
BACKUP_DIR=$HOME/.local/share/dotfiles-backup/
REMOTE_REPO=git@github.com:FluxAugur/mac-os-dotfiles.git

function dotfiles() {
  git --git-dir=$LOCAL_REPO --work-tree=$HOME "$@"
}

# -- Bootstrap
LOCAL_EXISTS=0
if [ ! -d "$LOCAL_REPO" ]; then
  LOCAL_EXISTS=1
fi

git ls-remote $REMOTE_REPO > /dev/null 2>&1
REMOTE_EXISTS=$?
if [ "$REMOTE_EXISTS" == "1" ]; then
  echo "Could not find '$REMOTE_REPO'"
  if [ "$LOCAL_EXISTS" == "1" ]; then
    echo "Could not find '$LOCAL_REPO'"
    echo -n "Creating local repo at '$LOCAL_REPO' ... "
    git init --bare $LOCAL_REPO > /dev/null 2>&1
    echo "done."
  else
    echo -n "Creating remote repo at '$REMOTE_REPO' ... "
    cd $LOCAL_REPO
    github-create
    echo "done."
  fi
else
  if [ "$LOCAL_EXISTS" == "1" ]; then
    echo "Could not find '$LOCAL_REPO'"
    echo -n "Cloning remote repo to '$LOCAL_REPO' ... "
    git clone --bare $REMOTE_REPO $LOCAL_REPO > /dev/null 2>&1
    echo "done."
  fi
fi

echo "Backing up dotfiles to '$BACKUP_DIR'"
mkdir -p $BACKUP_DIR
# dotfiles checkout 2>&1 | egrep "\s+\." | awk \{'print $2'\} | xargs -I{} mv {} $BACKUP_DIR{}
dotfiles checkout
dotfiles config --local stats.showUntrackedFiles no

# -- Setup
# shellcheck source=$HOME/.local/share/bin/dot-setup
source "$HOME/.local/share/bin/dot-setup"
