import algorithm

proc reversed*[T](a: openArray[T], first, last: int): seq[T] =
  result = newSeq[T](last - first + 1)
  var x = first
  var y = last
  while x <= last:
    result[x] = a[y]
    dec(y)
    inc(x)

proc reversed*[T](a: openArray[T]): seq[T] =
  reversed(a, 0, a.high)

var c = @[0]
for i in 1..10000000:
  c.add(i)

# 2.6 s
#for i in 0..10:
#  var d = c
#  reverse(d)

# 1.5 s
for i in 0..10:
  var d = reversed(c)
