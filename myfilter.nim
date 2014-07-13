import sequtils

var x: seq[int] = @[]
for i in 1..100_000_000:
  x.add(i)

#var y = filter(x, proc(a): bool = a mod 2 == 0) # slow
#echo y[1000]
#echo y.len

#keepIf(x, proc(a): bool = a mod 2 == 0) # fast
#echo x[1000]
#echo x.len
