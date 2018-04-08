import random, strutils, algorithm, sequtils
randomize()

var
  problem = newSeqWith(4, rand(1..8))
  stack = newSeq[float]()
  digits = newSeq[int]()

echo "Make 24 with the digits: ", problem

template op(c) =
  let a = stack.pop
  stack.add c(stack.pop, a)

for c in stdin.readLine:
  case c
  of '1'..'9':
    digits.add c.ord - '0'.ord
    stack.add float(c.ord - '0'.ord)
  of '+': op `+`
  of '*': op `*`
  of '-': op `-`
  of '/': op `/`
  of Whitespace: discard
  else: raise ValueError.newException "Wrong char: " & c

sort digits, cmp[int]
sort problem, cmp[int]
if digits.deduplicate != problem.deduplicate:
  raise ValueError.newException "Not using the given digits."
if stack.len != 1:
  raise ValueError.newException "Wrong expression."
echo "Result: ", stack[0]
echo if abs(stack[0] - 24) < 0.001: "Good job!" else: "Try again."
