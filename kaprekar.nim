import strutils, sequtils

proc k(n): bool =
  let n2 = $(n*n)
  for i in 0 .. <n2.len:
    let a = if i > 0: parseInt n2[0 .. <i] else: 0
    let b = parseInt n2[i .. n2.high]
    if b > 0 and a + b == n:
      return true

echo toSeq(1..10_000).filter(k)
echo len toSeq(1..1_000_000).filter(k)
