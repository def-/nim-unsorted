# nim js hello.nim
import tables

echo "Hello World"

var xs = @[0,1,2]

echo xs

xs.add(3)

echo xs

var y = {'a': 2, 'b': 3, 'c': 4}.toTable
echo y
echo y['a']

echo int64.high

echo "foobar".len
