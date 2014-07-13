const size = 100_000
var a: array[size, int]
var sum = 0
while sum < 100_000_000:
  for i in 0..a.high:
    a[i] += 1

  sum = 0
  for x in a:
    sum += x
echo sum
