type Singleton = object
  foo*: int

var single* = Singleton(foo: 0)
