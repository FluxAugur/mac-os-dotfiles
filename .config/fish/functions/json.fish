function json -d "Syntax-highlight JSON strings or files"
  if [ -t 0 ]
    echo $argv | python -mjson.tool | pygmentize -l javascript
  else
    python -mjson.tool | pygmentize -l javascript
  end
end
