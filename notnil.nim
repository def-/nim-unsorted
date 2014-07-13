proc safePrint(x: string not nil) =
  echo x

var s: string not nil

safePrint "foo"
safePrint s
