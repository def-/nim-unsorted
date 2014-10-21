type
  Maybe[T] = object
    case hasValue: bool
    of true: value: T
    else: nil

proc Just[T](value: T): Maybe[T] =
  Maybe[T](hasValue: true, value: value)

proc Nothing[T]: Maybe[T] =
  Maybe[T](hasValue: false)

var
  x = Just[int](12)
  y = Nothing[int]()

proc printIt(it: Maybe[int]) =
  if it.hasValue: echo "x is ", it.value
  else: echo "x is missing"

printIt x
printIt y
