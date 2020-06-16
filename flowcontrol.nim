# We can jump out of multiple loops using a named block and break
block outer:
  for i in 0..1000:
    for j in 0..1000:
      if i + j == 3:
        break outer

# Try-except-finally
var f = open "input.txt"
try:
  var s = readLine f
except IOError:
  echo "An error occured!"
finally:
  close f
