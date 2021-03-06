from math import sqrt

proc sumProperDivisors(x: int, checkLess: bool): int =
  template check(divNum) =
    if x mod divNum == 0:
      result += divNum + x div divNum
      if checkLess and result >= x:
        return 0

  result = 1
  let maxPD = sqrt(x.float).int
  if x mod 2 == 0:
    for divNum in 2..maxPD:
      check divNum
  else:
    for divNum in countup(3, maxPD, 2):
      check divNum

#for n in countdown(524_000_000, 2):
for n in countdown(20_000, 2):
  let m = sumProperDivisors(n, true)
  if m != 0 and n == sumProperDivisors(m, false):
    echo m, " ", n
