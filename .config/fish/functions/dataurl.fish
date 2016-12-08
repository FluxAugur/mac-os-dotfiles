function dataurl -d "Create a data URL from a file"
  set -l mimeType (file -b --mime-type $argv)
  if echo $mimeType == "text/*"
    set -l mimeType "$mimeType;charset=utf-8"
  end
  echo "data:$mimeType;base64,"(openssl base64 -in $argv | tr -d '\n')
end
