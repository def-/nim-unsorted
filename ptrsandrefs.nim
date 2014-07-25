# There are two types of pointers in Nimrod. Safe,
# garbage-collected references and unsafe pointers.

# Create a safe reference:
type Foo = ref object
  x, y: float

var f: Foo
new f

# Accessing the reference:
echo f[]

# When accessing values the dereference operator [] can be left out:
echo f[].x
f[].y = 12
echo f.y
f.x = 13.5

# Create an (unsafe) pointer to an int variable:
var x = 3
var p = addr x

# Access the integer variable through the pointer:
echo p[]
p[] = 42

# Change the pointer to refer to another object:
var y = 12
p = addr y

# Change the pointer to not point to any object:
p = nil
