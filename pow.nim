import macros

proc `^`*(base: int, exp: int): int =
  var (base, exp) = (base, exp)
  result = 1

  while exp != 0:
    if (exp and 1) != 0:
      result *= base
    exp = exp shr 1
    base *= base

macro compiletime(n: int): expr =
  var sum = 0
  for i in 1..int(n.intVal):
    sum += 2^i
  result = parseExpr($sum)

echo compiletime(10)

#proc runtime(): int =
#  for i in 1..10000000:
#    result += 4^i
#
#echo runtime()

proc prime(n: int): int =
  var primes = @[2]
  for i in countup(3, int.high, step=2):
    var found = false
    for p in primes:
      if i mod p == 0:
        found = true
        break
    if not found:
      primes.add(i)
      if primes.len > n:
        return primes[n]

macro comp(): stmt =
  result = parseStmt("echo " & $prime(500))

#comp()
#echo prime(500)

#proc avg(filename: string): int =
#  var
#    file = open(filename)
#    count, sum = 0
#  for line in file.lines:
#    count += 1
#    sum += line.len
#  result = sum div count

#macro cavg(filename: string): expr =
#  let a = avg(filename.strVal)
#  result = parseExpr($a)

#echo avg("pow.nim")
#echo cavg("pow.nim")


type
  Position = tuple[x, y: float]

  GraphicKind = enum Circle, Rectangle

  PGraphic = ref Graphic
  Graphic = object of TObject
    pos: Position

    case kind: GraphicKind
    of Circle:
      radius: float
    of Rectangle:
      size: tuple[w, h: float]

var c = Graphic(kind: Circle, pos: (20.5,30.1),
                radius: 10.9)

var d = PGraphic(kind: Rectangle, pos: (10.0,15.0), size: (12.0,12.0))
echo d.pos
d.pos = (20.0,30.0)

type
  List*[T] = ref TList[T]
  TList[T] = object
    data: T
    next: List[T]

proc newList*[T](data: T): List[T] =
  new(result)
  result.data = data

proc insert*[T](x: var List[T], y: List[T]) =
  let tmp = x.next
  x.next = y
  y.next = tmp

var x = newList("foo")
x.insert(newList("bar"))
