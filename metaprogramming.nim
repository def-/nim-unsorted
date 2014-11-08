# You can define your own infix operators:

proc `^`*[T: SomeInteger](base: T, exp: T): T =
  var (base, exp) = (base, exp)
  result = 1

  while exp != 0:
    if (exp and 1) != 0:
      result *= base
    exp = exp shr 1
    base *= base

echo 2 ^ 10 # 1024

# "when" is a compile time "if" and can be used to prevent code from
# even being parsed at compile time, for example to write platform
# specific code:

when defined windows:
  echo "Call some Windows specific functions here"
elif defined linux:
  echo "Call some Linux specific functions here"
else:
  echo "Code for the other platforms"

# Normal code can be executed at compile time if it is in a static block:

static:
  echo "Hello Compile time world: ", 2 ^ 10

# As well as stored in compile time constants:

const x = 2 ^ 10

# Template calls are replaced at compile time.

import os

const debug = false

proc expensive: string =
  sleep(milsecs = 100)
  result = "That was difficult"

# The expensive() procedure has to be evaluated even when debug is false:
block:
  proc log(msg: string) =
    if debug:
      echo msg

  for i in 1..10:
    log expensive()

# This can be prevented using templates:
block:
  template log(msg: string) =
    if debug:
      echo msg

  for i in 1..10:
    log expensive()

# Templates have a special syntax for use with statement parameters:

template times(x: expr, y: stmt): stmt =
  for i in 1..x:
    y

10.times: # or times 10:
  echo "hi"
  echo "bye"

# Term Rewriting Templates can be used to write your own optimizations:

block:
  template optLog1{a and a}(a): auto = a
  template optLog2{a and (b or (not b))}(a,b): auto = a
  template optLog3{a and not a}(a: int): auto = 0

  var
    x = 12
    s = x and x
    # Hint: optLog1(x) --> ’x’ [Pattern]

    r = (x and x) and ((s or s) or (not (s or s)))
    # Hint: optLog2(x and x, s or s) --> ’x and x’ [Pattern]
    # Hint: optLog1(x) --> ’x’ [Pattern]

    q = (s and not x) and not (s and not x)
    # Hint: optLog3(s and not x) --> ’0’ [Pattern]

# The most powerful metaprogramming capabilities are offered by
# Macros. They can generate source code or even an AST directly.
# dumpTree can be useful when creating an AST, as it shows you the AST
# of any code

import macros

dumpTree:
  if x:
    if y:
      p0
    else:
      p1
  else:
    if y:
      p2
    else:
      p3

# This prints:
# StmtList
#   IfStmt
#     ElifBranch
#       Ident !"x"
#       StmtList
#         IfStmt
#           ElifBranch
#             Ident !"y"
#             StmtList
#               Ident !"p0"
#           Else
#             StmtList
#               Ident !"p1"
#     Else
#       StmtList
#         IfStmt
#           ElifBranch
#             Ident !"y"
#             StmtList
#               Ident !"p2"
#           Else
#             StmtList
#               Ident !"p3"

# Using this information we could create an if over two values:

proc newIfElse(c, t, e): PNimrodNode {.compiletime.} =
  result = newIfStmt((c, t))
  result.add(newNimNode(nnkElse).add(e))

macro if2(x, y: expr; z: stmt): stmt {.immediate.} =
  var parts: array[4, PNimrodNode]
  for i in parts.low .. parts.high:
    parts[i] = newNimNode(nnkDiscardStmt).add(nil)

  assert z.kind == nnkStmtList
  assert z.len <= 4

  for i in 0 .. <z.len:
    assert z[i].kind == nnkCall
    assert z[i].len == 2

    var j = 0

    case $z[i][0].ident
    of "then":  j = 0
    of "else1": j = 1
    of "else2": j = 2
    of "else3": j = 3
    else: assert false

    parts[j] = z[i][1].last

  result = newIfElse(x,
    newIfElse(y, parts[0], parts[1]),
    newIfElse(y, parts[2], parts[3]))

if2 2 > 1, 3 < 2:
  then:
    echo "1"
  else1:
    echo "2"
  else2:
    echo "3"
  else3:
    echo "4"

# Missing cases are supported:
if2 2 > 1, 3 < 2:
  then:
    echo "1"
  else2:
    echo "3"
  else3:
    echo "4"

# Order can be swapped:
if2 2 > 1, 3 < 2:
  then:
    echo "1"
  else2:
    echo "3"
  else1:
    echo "2"
  else3:
    echo "4"

# Nested:
if2 2 > 1, 3 < 2:
  then:
    if2 2 > 1, 3 < 2:
      then:
        echo "1"
      else2:
        echo "3"
      else1:
        echo "2"
      else3:
        echo "4"
  else2:
    if2 2 > 1, 3 < 2:
      then:
        echo "1"
      else2:
        echo "3"
      else1:
        echo "2"
      else3:
        echo "4"
  else1:
    if2 2 > 1, 3 < 2:
      then:
        echo "1"
      else2:
        echo "3"
      else1:
        echo "2"
      else3:
        echo "4"
  else3:
    if2 2 > 1, 3 < 2:
      then:
        echo "1"
      else2:
        echo "3"
      else1:
        echo "2"
      else3:
        echo "4"
