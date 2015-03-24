proc printer(x: int): proc =
  proc y() =
    echo "hello " & $x
  return y

proc callMe(p: auto) =
  for i in 1..3:
    p()

var printer10 = printer(10)
printer10()

echo ""

callMe(printer10)

echo ""

var printers = @[printer10]
printers.add(printer(9))
printers.add(printer(8))

for p in printers:
  p()
