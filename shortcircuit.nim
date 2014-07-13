proc a(x): bool =
  echo "a called"
  result = x
proc b(x): bool =
  echo "b called"
  result = x

let x = a(false) and b(true) # echoes "a called"

let y = a(true) or b(true) # echoes "a called"

# You should not rely on the order of the procedures being called, as that can be reversed, for example for the a > b, which is implemented as b < a:

let z = a(true) > b(true) # echoes "b called" first, then "a called"
