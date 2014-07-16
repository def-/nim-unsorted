proc reversed(x) =
  for i in countdown(x.high, x.low):
    echo i

reversed(@[-19, 7, -4, 6])
