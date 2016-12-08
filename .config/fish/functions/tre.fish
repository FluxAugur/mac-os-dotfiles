function tre -d "`tree` with hidden files and color enabled, ignoring `.git` directories, listing directories first, piped into `less` unless output is small enough for one screen"
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst $argv | less -FRNX
end
