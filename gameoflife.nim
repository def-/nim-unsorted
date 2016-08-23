import os, strutils, random, sequtils
randomize()

var w, h: int
if paramCount() >= 2:
  w = parseInt paramStr 1
  h = parseInt paramStr 2
if w <= 0: w = 30
if h <= 0: h = 30

# Iterate over fields in the universe
iterator fields(a = (0,0), b = (h-1,w-1)): (int,int) =
  for y in a[0]..b[0]:
    for x in a[1]..b[1]:
      yield (y,x)

# Initialize
var univ, univNew = newSeqWith(h, newSeq[bool] w)

for y,x in fields():
  if random(10) < 1: univ[y][x] = true

while true:
  # Show
  stdout.write "\e[H"
  for y,x in fields():
    stdout.write if univ[y][x]: "\e[07m  \e[m" else: "  "
    if x == 0: stdout.write "\e[E"
  stdout.flushFile

  # Evolve
  for y,x in fields():
    var n = 0
    for y1,x1 in fields((y-1,x-1), (y+1,x+1)):
      if univ[(y1+h) mod h][(x1 + w) mod w]:
        inc n

    if univ[y][x]: dec n
    univNew[y][x] = n == 3 or (n == 2 and univ[y][x])
  swap univ, univNew

  sleep 200
