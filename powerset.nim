import sets, hashes

proc hash(x: HashSet[int]): Hash =
  var h = 0
  for i in x: h = h !& hash(i)
  result = !$h

proc powerset[T](inset: HashSet[T]): auto =
  result = toHashSet([initHashSet[T]()])

  for i in inset:
    var tmp = result
    for j in result:
      var k = j
      k.incl(i)
      tmp.incl(k)
    result = tmp

echo powerset(toHashSet([1,2,3,4]))
