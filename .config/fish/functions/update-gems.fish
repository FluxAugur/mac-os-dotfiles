function update-gems -d "Update and cleanup Ruby, gem, and system and global gems"
  command gem update --system; and gem update; and gem cleanup
end
