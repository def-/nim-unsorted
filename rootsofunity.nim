import complex, math

proc rect(r, phi: float): Complex64 = complex64(r * cos(phi), sin(phi))

proc croots(n: int): seq[Complex64] =
  result = @[]
  if n <= 0: return
  for k in 0 ..< n:
    result.add rect(1, 2 * k.float * Pi / n.float)

for nr in 2..10:
  echo nr, " ", croots(nr)
