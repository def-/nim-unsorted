import math, random, strfmt
randomize()

const
  maxN = 20
  times = 1_000_000

proc factorial(n: int): float =
  result = 1
  for i in 1 .. n:
    result *= i.float

proc expected(n: int): float =
  for i in 1 .. n:
    result += factorial(n) / pow(n.float, i.float) / factorial(n - i)

proc test(n, times: int): int =
  for i in 1 .. times:
    var
      x = 1
      bits = 0
    while (bits and x) == 0:
      inc result
      bits = bits or x
      x = 1 shl rand(n+1)

echo " n\tavg\texp.\tdiff"
echo "-------------------------------"
for n in 1 .. maxN:
  let cnt = test(n, times)
  let avg = cnt.float / times
  let theory = expected(n)
  let diff = (avg / theory - 1) * 100
  printlnfmt "{:2} {:8.4f} {:8.4f} {:6.3f}%", n, avg, theory, diff
