function json -d "Syntax-highlight JSON strings or files"
  if test (count $argv) -gt 0
    echo $argv | python -mjson.tool | pygmentize -l javascript
  else
    python -mjson.tool | pygmentize -l javascript
  end
end
