template optLog1{a and a}(a): auto = a
template optLog2{a and (b or (not b))}(a,b): auto = a
template optLog3{a and not a}(a: int): auto = 0

var
  x = 12
  s = x and x
    # Hint: optLog1(x) --> 'x' [Pattern]
  r = (x and x) and ((s or s) or (not (s or s)))
    # Hint: optLog2(x, s or s) --> 'x' [Pattern]
  q = (s and not x) and not (s and not x)
