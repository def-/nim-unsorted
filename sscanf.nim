import macros

macro sscanf(n: varargs[expr]): stmt =
  let
    n0 = n[0].strVal
    n1 = n[1].strVal

  var
    n0pos = 0
    n1pos = 0
    varpos = 2

  while n1pos < n1.len:
    if n1[n1pos] == '%':
      inc n1pos
      case n1[n1pos]
      of 'd':
        assert n[varpos].kind == nnkIntLit
        
        n[varpos].intVal = 
    else:
      inc n0pos
      inc n1pos

  for i in 2 .. <n.len:
    echo i

var
  name: string
  age: int

sscanf("Hello Dennis: 24 years", "Hello %s: %d years", name, age)
