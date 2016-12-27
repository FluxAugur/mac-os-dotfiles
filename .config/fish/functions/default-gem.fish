function default-gem -d "Install gem and add to default-gems list"
  gem install $argv
  echo "$argv" >> "$HOME/.config/rbenv-default-gems/default-gems"
  cat "$HOME/.config/rbenv-default-gems/default-gems" | uniq > "$HOME/.tmp-default-gems"
  mv "$HOME/.tmp-default-gems" "$HOME/.config/rbenv-default-gems/default-gems"
end
