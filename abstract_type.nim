# In Nimrod type classes can be seen as an abstract type. Type classes specify
# interfaces, which can be instantiated by concrete types.
type
  Comparable = generic x, y
    (x < y) is bool

  Container[T] = generic c
    c.len is ordinal
    items(c) is iterator
    for value in c:
      type(value) is T
