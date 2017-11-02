# The simplest form of initialization works, but is a bit cumbersome to write:
proc foo(): string =
  echo "Foo()"
  "mystring"

let n = 100
var ws = newSeq[string](n)
for i in 0 ..< n: ws[i] = foo()

# If actual values instead of references are stored in the sequence, then
# objects can be initialized like this. Objects are distinct, but the
# initializer foo() is called only once, then copies of the resulting object
# are made:
proc newSeqWith[T](len: int, init: T): seq[T] =
  result = newSeq[T] len
  for i in 0 ..< len:
    result[i] = init

var xs = newSeqWith(n, foo())

# To get the initial behaviour, where foo() is called to create each object, a
# template can be used:
template newSeqWith2(len: int, init): untyped =
  var result {.gensym.} = newSeq[type(init)](len)
  for i in 0 ..< len:
    result[i] = init
  result

var ys = newSeqWith2(n, foo())
