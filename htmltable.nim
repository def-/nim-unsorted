import random, htmlgen
randomize()

template randTD: untyped = td($random(1000..9999))
proc randTR(x: int): auto =
  tr(td($x, style="font-weight: bold"), randTD, randTD, randTD)

echo table(
  tr(th"", th"X", th"Y", th"Z"),
  randTR 1,
  randTR 2,
  randTR 3,
  randTR 4,
  randTR 5)
