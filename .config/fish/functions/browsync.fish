function browsync -d "Start browser-sync server watching files given in arguments"
  command browser-sync start --server --files $argv
end
