import os
from strutils import parseInt
#var x = 3.5
#echo x
#echo int(x)

var str = "Hello World"

for i in 1..10:
  echo str & $i

type dice = range[1..6]
var d: dice = 4
#d = 7 # error: out of range

var ds: array[100, dice]
ds[50] = 6
ds[60..69] = ds[50..59]
for d in ds:
  echo d

var newDs: seq[dice] = @[]
for i,d in ds:
  if i > 10 and d == 6:
    newDs.add(d)
echo newDs

proc sum[T](x, y: T): T {.noSideEffect.} =
  x + y

var mama = 12

proc sum(xs: seq[int|string]): int {.noSideEffect.} =
  for x in xs:
    let y =
      when x is int: x
      else: parseInt(x)
    result += y

proc printer(x: int): proc =
  proc y() =
    echo "hello " & $x
  return y

proc callMe(p: auto) =
  for i in 1..10:
    p()

var printer10 = printer(10)
var printer20 = printer(20)
printer10()
printer20()
callMe(printer10)

echo sum(@[10,20,30])
echo(@[10,20,30].sum())

proc dimensions(): tuple[w,h: int] =
  (15,20)

echo dimensions().w

discard dimensions()
#echo sum(x,y)
#echo sum(x,y)
#echo x.sum(y)
#echo x.sum y
#echo sum(@["12","14"])

echo sum(12.5, 13.5)
echo sum(@["12","14"])

proc abc(x: var string) =
  x[0] = 'c'

var qq = "foobar"
abc(qq)
echo qq

var st: ref string
new(st)
st[] = "foobar"
echo st[]

type Some = tuple
  x: int
  y: int
  z: array[1000, int]

var som: Some
echo som.z[50]

var som2: ref Some
new som2
echo som2.z[50]

#proc doSth(s: ref Some) =
#  if s.z[600] == 1:
#    echo "hi =)"
#
#for i in 1..100000000:
#  doSth(som2)

template times(x, y) =
  for i in 1..x:
    y

10.times:
  echo "hi"

proc x1(): int =
  echo "x()"
  2

proc y1(): int =
  echo "y()"
  3

echo(x1() > y1())


const debug = false

import macros

template log*(msg: string) =
  if debug:
    echo msg

proc expensiveConstruct(): string =
  sleep(milsecs = 1000)
  result = "That was difficult"

10.times:
  log(expensiveConstruct())

proc `^`*(base: int, exp: int): int =
  var (base, exp) = (base, exp)
  result = 1

  while exp != 0:
    if (exp and 1) != 0:
      result *= base
    exp = exp shr 1
    base *= base

macro potSum(n: int): int =
  var sum = 0
  for i in 1..int(n.intVal):
    sum += 2^i
  result = newIntLitNode(sum)

echo potSum(10)

proc `+=`[T: float|float32|float64](x: var T, y: T) =
  x = x + y

macro `:=`(assign, data) =
  assert(assign.kind == nnkIdent)
  let to = assign.strVal

  assert(data.len == 3)
  assert(data.kind == nnkInfix)

  let m1 = data[0]
  assert(m1.kind == nnkIdent)
  assert(m1.strVal == "/")

  let m2 = data[1]
  assert(m2.kind == nnkIdent)
  let from1 = m2.strVal

  let m3 = data[2]
  assert(m3.kind == nnkIdent)
  let from2 = m3.strVal

  result = parseStmt("isMult(" & from1 & ", " & to & ", " & from2 & ")")

var Δ = 1
Δ.inc()
echo(Δ)
