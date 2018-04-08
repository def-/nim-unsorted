import sequtils, permutationsswap, sugar

proc det(a: seq[seq[float]]): float =
  let n = toSeq 0..a.high
  for sigma, sign in n.permutations:
    result += sign.float * n.map((i: int) => a[i][sigma[i]]).foldl(a * b)

proc perm(a: seq[seq[float]]): float =
  let n = toSeq 0..a.high
  for sigma, sign in n.permutations:
    result += n.map((i: int) => a[i][sigma[i]]).foldl(a * b)

for a in [
    @[ @[1.0, 2.0]
     , @[3.0, 4.0]
    ],
    @[ @[ 1.0,  2,  3,  4]
     , @[ 4.0,  5,  6,  7]
     , @[ 7.0,  8,  9, 10]
     , @[10.0, 11, 12, 13]
    ],
    @[ @[ 0.0,  1,  2,  3,  4]
     , @[ 5.0,  6,  7,  8,  9]
     , @[10.0, 11, 12, 13, 14]
     , @[15.0, 16, 17, 18, 19]
     , @[20.0, 21, 22, 23, 24]
    ] ]:
  echo a
  echo "perm: ", a.perm, " det: ", a.det
