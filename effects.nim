proc lastChar(): char =
  let line = stdin.readLine()
  # Hint: FReadIO [User]
  if line.len == 0:
    raise newException(EIO, "IO")
    # Hint: ref EIO [User]
  return line[line.high]
  {.effects.}

proc sum[T: int|int64|float](x, y: T): T =
  x + y

echo sum(12.5, 13.5)
#echo sum("foo", "bar") # error: type mismatch for sum
