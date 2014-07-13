import tables, sequtils

proc asKeyVal(x): auto = cast[seq[tuple[key: char, val: int]]](x)

let keys = @['a','b','c']
let values = @[1, 2, 3]

let table = toTable zip(keys, values).asKeyVal
