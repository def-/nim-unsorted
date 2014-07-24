iterator reversed[T](x: T) =
  for i in countdown(high(x), low(x)):
    yield x[i]

var ar = ['a','b','c','d']
var sq = @['a','b','c','d']
var st = "abcd"

for i in ar: stdout.write i," "
echo ""
for i in sq: stdout.write i," "
echo ""
for i in st: stdout.write i," "
echo ""

for i,x in ar: stdout.write i," ",x," "
echo ""
for i,x in sq: stdout.write i," ",x," "
echo ""
for i,x in st: stdout.write i," ",x," "
echo ""

for i in reversed(ar): stdout.write i," "
echo ""
for i in reversed(sq): stdout.write i," "
echo ""
for i in st: stdout.write i," "
echo ""
