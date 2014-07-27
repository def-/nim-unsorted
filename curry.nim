import future

proc fs[T1,T2](f: T1 -> T2, s: seq[T1]): seq[T2] = s.map f

proc f1(x: int): int = x * 2
proc f2(x: int): int = x * x

# This should work without an explicit mention of other parameters, TODO: Write
# a macro for that
var fsf1 = (s: seq[int]) => f1.fs s
var fsf2 = (s: seq[int]) => f2.fs s

echo fsf1(@[0,1,2,3])
echo fsf2(@[0,1,2,3])
echo fsf1(@[2,4,6,8])
echo fsf2(@[2,4,6,8])
