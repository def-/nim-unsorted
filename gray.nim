proc grayEncode(n: int): int =
  n xor (n shr 1)

proc grayDecode(n: int): int =
  result = n
  var t = n
  while t > 0:
    t = t shr 1
    result = result xor t

import strutils

for i in 0 .. 32:
  echo i, " => ", toBin(grayEncode(i), 6), " => ", grayDecode(grayEncode(i))
