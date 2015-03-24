import strutils
let s = "123"
var f: float
try:
  f = parseFloat s
except ValueError:
  echo "not numeric"

if s.contains AllChars - Digits:
  echo "not a positive integer"
