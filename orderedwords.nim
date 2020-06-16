import strutils

proc isSorted(s: string): bool =
  var last = low(char)
  for c in s:
    if c < last:
      return false
    last = c
  return true

var mx = 0
var words: seq[string] = @[]

var f = open("wordlist.txt")
var word = ""
while f.readLine(word):
  if word.len >= mx and isSorted(word):
    if word.len > mx:
      words = @[]
      mx = word.len
    words.add(word)
echo words.join(" ")
