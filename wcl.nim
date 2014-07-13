import strutils, memfiles

#proc main =
#  var
#    s = 0
#    size = 4096
#  #  buf = cast[ptr string](alloc0(4096))
#  #let file = system.open("log")
#  #while size == 4096:
#  #  size = file.readBuffer(buf, 4096)
#  #  for i in 0..size-1:
#  #    if buf[i] == '\l':
#  #      s += 1
#  let file = memfiles.open("log")
#  for c in cast[cstring](file.mem):
#    if c == '\l':
#      s += 1
#
#  echo s
#
#main()

let file = system.open("/media/log")
var
  s = 0
  size = 4096
  #buf: array[4096, char]
  buf = cast[ptr string](alloc0(SIZE))

# 0.2
# wc -l

# 0.8
#for c in file.readAll():
#  if c == '\l':
#    s += 1

# 0.9
#s = file.readAll().countLines()

# way too long
#try:
#  while true:
#    if file.readChar() == '\l':
#      s += 1
#except FReadIO:
#  discard

# 0.76
#while size == 4096:
#  size = file.readChars(buf, 0, 4096)
#  for c in buf:
#    if c == '\l':
#      s += 1

# 0.45
while size == 4096:
  size = file.readBuffer(buf, 4096)
  for i in 0..size:
    if buf[i] == '\l':
      s += 1

# 0.46
#let file = memfiles.open("log")
#for c in cast[cstring](file.mem):
#  if c == '\l':
#    s += 1

# 0.53
#let file = memfiles.open("log")
#let m = cast[cstring](file.mem)
#var i = 0
#while true:
#  if m[i] == '\0':
#    break
#  elif m[i] == '\l':
#    s += 1
#  i += 1

echo s
