if x == 0:
  foo()
elif x == 1:
  bar()
elif x == 2:
  baz()
else:
  boz()

case x
of 0:
  foo()
of 2,5,9:
  baz()
of 10..20, 40..50:
  baz()
else: # All cases must be covered
  boz()
