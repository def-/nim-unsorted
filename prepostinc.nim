proc `++` *[T](x: var T): T =
  result = x
  inc x

proc `+-` *[T](x: var T): T =
  inc x
  result = x

var x = 0
echo(++x)
echo x.`+-`
echo x
