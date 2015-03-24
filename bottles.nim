proc bottles(n: int): string =
  case n
  of 0: "no more bottles"
  of 1: "1 bottle"
  else: $n & " bottles"

for n in countdown(99, 1):
  echo n.bottles, " of beer on the wall, ", n.bottles, " of beer."
  echo "Take one down and pass it around, ", (n-1).bottles, " on the wall.\n"

echo "No more bottles of beer on the wall, no more bottles of beer."
echo "Go to the store and buy some more, 99 bottles of beer on the wall."
