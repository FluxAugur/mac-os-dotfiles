function default-gem -d "Install gem and add to default-gems list"
  command gem install $argv
  command echo "$argv" >> "$HOME/.config/rbenv-default-gems/default-gems"
  command cat "$HOME/.config/rbenv-default-gems/default-gems" | uniq > "$HOME/.tmp-default-gems"
  command mv "$HOME/.tmp-default-gems" "$HOME/.config/rbenv-default-gems/default-gems"
end
