function fs -d "Determine size of a file or total size of a directory"
  if du -b /dev/null > /dev/null 2>&1
    set -l arg "-sbh"
  else
    set -l arg "-sh"
  end
  echo $arg
  if count $argv > /dev/null
    du $arg -- $argv
  else
    du $arg .[^.]* ./*
  end
end
