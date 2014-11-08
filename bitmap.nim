# TODO: There are more bitmap tasks!

import unsigned, strutils, math

type
  Luminance = uint8
  Index = int

  Pixel = tuple
    r, g, b: Luminance

  Image = object
    w, h: Index
    pixels: seq[Pixel]

  Point = tuple
    x, y: Index

proc px(r, g, b): Pixel =
  result.r = r.uint8
  result.g = g.uint8
  result.b = b.uint8

proc img(w, h: int): Image =
  result.w = w
  result.h = h
  result.pixels.newSeq(w * h)

const
  Black = px(  0,   0,   0)
  White = px(255, 255, 255)

iterator indices(img: Image): tuple[x, y: int] =
  for y in 0 .. < img.h:
    for x in 0 .. < img.w:
      yield (x,y)

proc `[]`(img: Image, x, y: int): Pixel =
  img.pixels[y * img.w + x]

proc `[]`(img: Image, p: Point): Pixel =
  img.pixels[p.y * img.w + p.x]

proc `[]=`(img: var Image, x, y: int, c: Pixel) =
  img.pixels[y * img.w + x] = c

proc `[]=`(img: var Image, p: Point, c: Pixel) =
  img.pixels[p.y * img.w + p.x] = c

proc fill(img: var Image, color: Pixel) =
  for x,y in img.indices:
    img[x,y] = color

proc print(img: Image) =
  using stdout
  for x,y in img.indices:
    if img[x,y] == White:
      write ' '
    else:
      write 'H'
    write "\n"

proc writePPM(img: Image, f: File) =
  f.writeln "P6\n", img.w, " ", img.h, "\n255"

  for x,y in img.indices:
    f.write char(img[x,y].r)
    f.write char(img[x,y].g)
    f.write char(img[x,y].b)

proc readPPM(f: File): Image =
  if f.readLine != "P6":
    raise newException(Exception, "Invalid file format")

  var line = ""
  while f.readLine(line):
    if line[0] != '#':
      break

  var parts = line.split(" ")
  result = img(parseInt parts[0], parseInt parts[1])

  if f.readLine != "255":
    raise newException(Exception, "Invalid file format")

  var
    arr: array[256, int8]
    read = f.readBytes(arr, 0, 256)
    pos = 0

  while read != 0:
    for i in 0 .. < read:
      case pos mod 3
      of 0: result.pixels[pos div 3].r = arr[i].uint8
      of 1: result.pixels[pos div 3].g = arr[i].uint8
      of 2: result.pixels[pos div 3].b = arr[i].uint8
      else: discard

      inc pos

    read = f.readBytes(arr, 0, 256)

proc line(img: var Image, p, q: Point) =
  let
    dx = abs(q.x - p.x)
    sx = if p.x < q.x: 1 else: -1
    dy = abs(q.y - p.y)
    sy = if p.y < q.y: 1 else: -1

  var
    p = p
    q = q
    err = (if dx > dy: dx else: -dy) div 2
    e2 = 0

  while true:
    img[p] = Black
    if p == q:
      break
    e2 = err
    if e2 > -dx:
      err -= dy
      p.x += sx
    if e2 < dy:
      err += dx
      p.y += sy

when isMainModule:
  var x = img(64, 64)
  x.fill px(128,255,255)
  x[1,2] = px(255, 0, 0)
  x[3,4] = x[1,2]

  x.line((0,0), (50,20))

  var f = open("foo.ppm", fmWrite)
  x.writePPM(f)
  close(f)

  var y = readPPM(open("foo.ppm"))
  y.writePPM(open("bar.ppm", fmWrite))
