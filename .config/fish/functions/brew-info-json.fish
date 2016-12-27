function brew-info-json -d "Get JSON-formatted information about brews."
  # get all
  brew info --json=v1 --all > "$HOME/.local/share/brew-info-all.json"

  # get installed
  brew info --json=v1 --installed > "$HOME/.local/share/brew-info-installed.json"

  # get compact installed
  jq "map(select(.installed != [])) | map({name: .name, description: .desc, homepage: .homepage, version: .installed[].version, options: .installed[].used_options}) | sort_by(.name)" < "$HOME/.local/share/brew-info-all.json" > "$HOME/.local/share/brew-info-installed.compact.json"
end
