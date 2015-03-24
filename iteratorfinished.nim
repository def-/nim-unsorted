iterator iter(): int {.closure.} =
  var x = 0
  while x < 10:
    yield x
    inc x

proc finished[T](iter: auto; x: var T): bool =
  var y: T = iter()
  if finished(iter):
    result = true
  else:
    result = false
    x = y

var it = iter
var x = 5

while true:
  if finished(it, x): break
  echo "This is x: ", x
