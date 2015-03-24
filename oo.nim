type Foo* = object
  a: string
  b: string
  c: int

proc createFoo*(a, b: string, c: int): Foo =
  Foo(a: a, b: b, c: c)
