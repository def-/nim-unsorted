proc transpose[T](s: seq[seq[T]]): seq[seq[T]] =
  result = newSeq[seq[T]](s[0].len)
  for i in 0 ..< s[0].len:
    result[i] = newSeq[T](s.len)
    for j in 0 ..< s.len:
      result[i][j] = s[j][i]

let a = @[@[ 0, 1, 2, 3, 4],
          @[ 5, 6, 7, 8, 9],
          @[ 1, 0, 0, 0,42]]
echo transpose(a)

proc transpose[X, Y; T](s: array[Y, array[X, T]]): array[X, array[Y, T]] =
  for i in low(X)..high(X):
    for j in low(Y)..high(Y):
      result[i][j] = s[j][i]

let b = [[ 0, 1, 2, 3, 4],
         [ 5, 6, 7, 8, 9],
         [ 1, 0, 0, 0,42]]
let c = transpose(b)
for r in c:
  for i in r:
    stdout.write i, " "
  echo ""
