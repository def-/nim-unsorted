import os, times, strutils

if paramCount() == 0:
  try: stdout.write readFile("notes.txt")
  except EIO: discard
else:
  var f = open("notes.txt", fmAppend)
  f.writeln getTime()
  f.writeln "\t", commandLineParams().join(" ")
  f.close()
