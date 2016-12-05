function img2base64 -d "Converts $argv image to base64 and places on the clipboard."
  command openssl base64 < $argv | tr -d '\n' | pbcopy
end
