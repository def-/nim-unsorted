proc print(xs: varargs[string, `$`]) =
  for x in xs:
    echo x

print(12, "Rosetta", "Code", 15.54321)

print 12, "Rosetta", "Code", 15.54321, "is", "awesome!"

let args = @["12", "Rosetta", "Code", "15.54321"]
print(args)
