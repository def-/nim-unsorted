proc first(fn): auto =
  return fn()

proc second(): string =
  return "second"

echo first(second)
