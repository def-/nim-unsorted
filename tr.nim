import macros, sequtils

macro optMul{`*`(a,2)}(a: int): expr =
  let x = a
  return parseExpr("12")

template canonMul{`*`(a,b)}(a: int{lit}, b: int): int =
  b * a

var x: int
#for i in 1..1_000_000_000:
#  x += 2 * i

let
  colors = @["red", "yellow", "black"]
  f1 = filter(colors, proc(x): bool = x.len < 6)
  f2 = colors.filter do (x) -> bool : x.len > 5
