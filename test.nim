proc sth(y) =
  echo repr(y)

type Substring = tuple
  x: string
  s,e: int

var x = "foobarfoobarfoobar"

echo repr(x)

sth(x)

sth(repr(x[0..4]))
