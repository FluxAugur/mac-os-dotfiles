function gitio -d "Create a git.io short URL"
  if [ ! (count $argv) -eq 2 ]
    echo "Usage: `gitio slug url`"; and return 1
  end
  curl -i https://git.io/ -F "url=$argv[2]" -F "code=$argv[1]"
end
