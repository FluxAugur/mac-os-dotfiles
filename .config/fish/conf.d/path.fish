# configure PATH
if status --is-interactive
  # add Homebrew's sbin to path
  set -gx PATH "/usr/local/sbin" $PATH
  # add user binaries to path
  set -gx PATH "$HOME/.local/share/bin" $PATH
  # add gnu commands to path
  # set -gx PATH "/usr/local/opt/coreutils/libexec/gnubin" $PATH
  # add pnpm node binaries to path
  #set -gx PATH "$HOME/.pnpm/node_modules/.bin" $PATH
  # add rbenv binaries to path
  source (rbenv init -|psub)
end
