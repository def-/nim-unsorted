import strfmt

type Matrix[M,N: static[int]] = array[M, array[N, float]]

proc `$`(m: Matrix): string =
  result = "(["
  for r in m:
    if result.len > 2: result.add "]\n ["
    for val in r: result.add val.format("8.2f")
  result.add "])"

proc `*`[M,N,M2,N2](a: Matrix[M,N2]; b: Matrix[M2,N]): Matrix[M,N] =
  for i in low(result) .. high(result):
    for j in low(result[0]) .. high(result[0]):
      for k in low(a[0]) .. high(a[0]):
        result[i][j] += a[i][k] * b[k][j]

proc `^`[M,N](x: Matrix[M,N]; pow: Natural): Matrix[M,N] =
  echo result[0][0]
  for i in low(result) .. high(result):
    result[i][i] = 1 # TODO: Buggy, upload after bug fixed
  for i in 0 ..< pow:
    echo "Before:"
    echo result
    echo x
    result = result * x
    echo "After:"
    echo result

const m = [ [3.0, 2.0]
          , [2.0, 1.0]
          ]

echo m * m

for i in 0..4:
  echo "\n",i,":"
  echo m ^ i
