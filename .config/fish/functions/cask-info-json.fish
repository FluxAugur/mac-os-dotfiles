function cask-info-json -d "Get JSON-formatted information about casks."
  set -l a (count (brew cask list))
  set -l out "$HOME/.local/share/cask-info-installed.json"
  echo -n "[" > "$out"
  for c in (brew cask list)
    set a (math $a - 1)
    set -l d (brew cask info $c | head -n 2)
    set -l e (echo $d | sed -e 's/\(^.*\): /"\1 /' -e 's/ /"|"/g' -e 's/$/"/')
    set -l f (echo $e | awk -F '|' '{print "{\"name\":", $1, ",\"version\":", $2, ",\"homepage\":", $3, "}"}')
    echo -n "$f" >> "$out"
    if test $a -ne 0
      echo -n "," >> "$out"
    end
  end
  echo "]" >> "$out"
  jq "map({name: .name, homepage: .homepage, version: .version})" < "$out" > "$HOME/.local/share/cask-info-installed.compact.json"
  set -e a
  set -e c
  set -e d
  set -e f
end
