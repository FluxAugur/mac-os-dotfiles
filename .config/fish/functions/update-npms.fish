function update-npms -d "Update, dedupe, and prune npm and global packages"
  command pnpm i -g npm pnpm npm-check-updates; and pnpm i -g (ncu -g | cut -d' ' -f2); and npm -g ddp; and npm cache clean
end
