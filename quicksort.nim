proc quickSort[T](a: var openarray[T], l, r: int) =
  if r <= l: return
  let pivot = a[l]
  var (i, j) = (l, r)

  while i <= j:
    if a[i] < pivot:
      inc i
    elif a[j] > pivot:
      dec j
    elif i <= j:
      swap a[i], a[j]
      inc i
      dec j

  quickSort(a, l, j)
  quickSort(a, i, r)

proc quickSort*[T](a: var openarray[T]) =
  quickSort(a, 0, a.high)

var a = @[4, 65, 2, -31, 0, 99, 2, 83, 782]
quickSort a
echo a
