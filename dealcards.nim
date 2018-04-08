import sequtils, strutils, os

proc randomGenerator(seed: int): iterator: int =
  var seed = seed
  return iterator: int =
    while true:
      seed = int((seed.int64 * 214013 + 2531011) and int32.high)
      yield seed shr 16

proc deal(seed: int): seq[int] =
  const nc = 52
  result = toSeq countdown(nc - 1, 0)
  var rnd = randomGenerator seed
  for i in 0 ..< nc:
    let r = rnd()
    let j = (nc - 1) - r mod (nc - i)
    swap result[i], result[j]

proc show(cards: seq[int]) =
  var l = newSeq[string]()
  for c in cards:
    l.add "A23456789TJQK"[c div 4] & "CDHS"[c mod 4]
  for i in countup(0, cards.high, 8):
    echo " ", l[i..min(i+7, l.high)].join(" ")

let seed = if paramCount() == 1: paramStr(1).parseInt else: 11982
echo "Hand ", seed
let deck = deal seed
show deck
