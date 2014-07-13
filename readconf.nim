import strutils, os

proc readconf(fn): string =
  var f = open(fn)
  var boolval = false

  for lineUn in f.lines:
    # Assume whitespace is ignorable
    var line = lineUn.strip()
    if line == "" or line.startsWith("#"): continue

    boolval = true
    # Assume leading ";" means a false boolean
    if line.startsWith(";"):
      # Remove one or more leading semicolons
      line = line.strip(trailing = false)
      # If more than just one word, not a valid boolean
      if line.split().len != 1: continue
      boolval = false

    let bits = line.split()
    if len(bits) == 1:
      # Assume booleans are just one standalone word
      k = bits[0]
      v = boolval

  close(f)

echo readconf(paramStr(1))
