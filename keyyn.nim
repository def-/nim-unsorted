import pdcurses, strutils

system.echo "Press Y or N to continue"
while true:
  try:
    let char = chr(getch())
    if toLower(char) in "yn":
      system.echo char
      break
  except:
    system.echo "fail"
