import random, os
randomize()

const
  target = "METHINKS IT IS LIKE A WEASEL"
  alphabet = " ABCDEFGHIJLKLMNOPQRSTUVWXYZ"
  p = 0.05
  c = 100

proc rand(a: string): char = a[rand(a.low..a.high)]

proc negFitness(trial: string): int =
  for i in 0 ..< trial.len:
    if target[i] != trial[i]: inc result

proc mutate(parent: string): string =
  result = ""
  for c in parent: result.add if rand(1.0) < p: rand(alphabet) else: c

var parent = ""
for i in 1..target.len: parent.add rand(alphabet)

var i = 0
while parent != target:
  var copies = newSeq[string](c)
  for i in 0 ..< copies.len: copies[i] = mutate(parent)

  var best = copies[0]
  for i in 1 ..< copies.len:
    if negFitness(copies[i]) < negFitness(best): best = copies[i]
  parent = best

  echo i, " ", parent
  inc i
