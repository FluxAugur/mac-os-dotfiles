function update-npms -d "Update, dedupe, and prune npm and global packages"
  command npm i -g npm; and npm i -g npm-check-updates; ncu -g -u; npm -g ddp; npm -g prune
end
