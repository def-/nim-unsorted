import tables, math

#proc `~` * [IDX, A, B](arr: array[IDX, tuple[key: A, val: B]]): TTable[A, B] =
#  toTable(arr)
#
#var t = ~[("foo", 13), ("bar", 14)]
#echo t
#echo t["foo"]
#
#proc `{}`[A,B](t: var TTable[A, B], pairs: varargs[tuple[key: A, val: B]]) =
#  t = initTable[A, B](nextPowerOfTwo(pairs.len+10))
#  for key, val in items(pairs): t[key] = val

#var t: TTable[string, int]
#t{("foo", 12)}
#echo t

var x = {"key1": 14, "key2", "key3": 12}.toTable
echo x["key1"]
