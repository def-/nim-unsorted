# Array
# Length is known at compile time
var a = [1,2,3,4,5,6,7,8,9]
var b: array[128, int]
b[9] = 10
b[..8] = a
var c: array['a'..'d', float] = [1.0, 1.1, 1.2, 1.3]
c['b'] = 10000

# Seq
# Variable length sequences
var d = @[1,2,3,5,6,7,8,9]
d.add(10)
d.add([11,12,13,14])
d[0] = 0

var e: seq[float] = @[]
e.add(15.5)

var f = newSeq[string]()
f.add("foo")
f.add("bar")

# Tuples
# Fixed length, named
var g = (13, 13, 14)
g[0] = 12

var h: tuple[key: string, val: int] = ("foo", 100)

# A sequence of key-val tuples:
var i = {"foo": 12, "bar": 13}

# Set
# Bit vector of ordinals
var j: set[char]
j.incl('X')

var k = {'a'..'z', '0'..'9'}

j = j + k

# Tables
# Hash tables (there are also ordered hash tables and counting hash tables)
import tables
var l = initTable[string, int]()
l["foo"] = 12
l["bar"] = 13

var m = {"foo": 12, "bar": 13}.toTable
m["baz"] = 14

# Sets
# Hash sets (also ordered hash sets)
import sets
var n = initHashSet[string]()
n.incl("foo")

var o = ["foo", "bar", "baz"].toHashSet
o.incl("foobar")

# Queues
import deques
var p = initDeque[int]()
p.addLast(12)
p.addLast(13)
