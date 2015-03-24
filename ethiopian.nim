proc halve(x: int): int = x div 2
proc double(x: int): int = x * 2
proc even(x: int): bool = x mod 2 == 0

proc ethiopian(x, y: int): int =
  var x = x
  var y = y

  while x >= 1:
    if not even x:
      result += y
    x = halve x
    y = double y

echo ethiopian(17, 34)
