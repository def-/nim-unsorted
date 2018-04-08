import random
randomize()

proc rand[T](a: openarray[T]): T =
  a[rand(a.low..a.high)]

let ls = @["foo", "bar", "baz"]
echo ls.rand()

var xs: array[10..14, string]
for i in 10..14:
  xs[i] = "foo: " & $i

echo xs.rand()
