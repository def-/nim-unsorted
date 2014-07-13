# In Nimrod, a regular parameter of a procedure can be used as either a positional or a named parameter.

proc subtract(x, y): auto = x - y

echo subtract(5, 3)         # used as positional parameters
echo subtract(y = 3, x = 5) # used as named parameters
