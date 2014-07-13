import math

proc nosqr(n): seq[int] =
  result = @[]
  for i in 1..n:
    result.add(i + round(sqrt(float(i))))

echo nosqr(22)
echo nosqr(1_000_000)
