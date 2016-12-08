function a -d "Open the Atom editor in the given location, or current directory if no arguments"
  if [ (count $argv) -eq 0 ]
    atom .
  else
    atom $argv
  end
end
