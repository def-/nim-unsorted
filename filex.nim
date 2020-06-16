template upon(a, b, c) =
  var b = a
  c
  close(b)

upon open("input.txt"), i:
  upon open("output.txt", fmWrite), o:
    for line in i.lines:
      o.writeLine line
