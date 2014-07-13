type U0 = object of EBase
type U1 = object of EBase

proc baz(i) =
  if i > 0: raise newException(U1, "Some error")
  else: raise newException(U0, "Another error")

proc bar(i) =
  baz(i)

proc foo() =
  for i in 0..1:
    try:
      bar(i)
    except U0:
      echo "Function foo caught exception U0"

foo()
