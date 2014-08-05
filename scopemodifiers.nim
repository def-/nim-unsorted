# Identifiers annotated with a * are accessible from other modules
proc foo = echo "foo" # hidden
proc bar* = echo "bar" # acessible

type MyObject = object
  name*: string # accessible
  secretAge: int # hidden
