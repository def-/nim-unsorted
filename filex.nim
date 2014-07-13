import os

template upon(a: expr, b: expr, c: stmt) {.immediate.} =
  var b = a
  c
  close(b)

upon open("input.txt"), i:
  upon open("output.txt", fmWrite), o:
    for line in i.lines:
      o.writeln(line)
