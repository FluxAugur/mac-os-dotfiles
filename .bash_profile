export PATH="/usr/local/sbin:$PATH"

eval "$(rbenv init -)"

function dotfiles() {
  git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME "$@"
}

function github-create() {
  REPO_NAME=$1
  DIR_NAME=`basename $(pwd)`
  if [ "$REPO_NAME" = "" ]; then
    echo "Repo name (hit enter to use '$DIR_NAME')?"
    read REPO_NAME
  fi

  if [ "$REPO_NAME" = "" ]; then
    REPO_NAME=$DIR_NAME
  fi

  USER_NAME=`git config github.user`
  if [ "$USER_NAME" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    INVALID_CREDENTIALS=1
  fi

  TOKEN=`git config github.token`
  if [ "$TOKEN" = "" ]; then
    echo "Could not find token, run 'git config --global github.token <token>'"
    INVALID_CREDENTIALS=1
  fi

  if [ "$INVALID_CREDENTIALS" == "1" ]; then
    return 1
  fi

  echo -n "Creating Github repository '$REPO_NAME' ..."
  curl -u "$USER_NAME:$TOKEN" https://api.github.com/user/repos -d '{"name": "'$REPO_NAME'"}' > /dev/null 2>&1
  echo " done."

  echo -n "Pushing local code to remote ..."
  git remote add origin git@github.com:$USER_NAME:$REPO_NAME.git > /dev/null 2>&1
  git push -u origin master > /dev/null 2>&1
  echo " done."
}
