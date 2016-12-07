function update-os -d "Update macOS software"
  command sudo softwareupdate -i -a
end
