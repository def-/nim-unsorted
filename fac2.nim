proc factorial(x: int): int =
  if x > 0: x * factorial(x - 1)
  else: 1
