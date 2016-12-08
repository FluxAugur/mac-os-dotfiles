set fish_greeting

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias dot "git --git-dir=$DOTFILES --work-tree=$HOME"

set -gx NPM_CHECK_INSTALLER "pnpm npm-check -u"
# set -gx MANPATH "/usr/local/opt/coreutils/libexec/gnuman" $PATH
