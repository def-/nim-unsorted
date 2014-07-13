iterator mapiter[T,O](iter: iterator(): T {.closure.}, transform_elem: proc(e:T):O): O {.closure.} =
  for x in iter():
    yield transform_elem(x)

iterator it(): int {.closure.} =
  for y in 1..10:
    yield y

for z in mapiter(it, proc(x: int): string = $(x/2) & " oh yeah"):
  echo z
