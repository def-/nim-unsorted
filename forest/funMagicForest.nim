# http://unriskinsight.blogspot.de/2014/06/fast-functional-goats-lions-and-wolves.html
#
# Goats Wolves Lions    C++11  Nimrod (functional)
#    17     55     6     0.00    0.00
#   117    155   106     0.17    0.31
#   217    255   206     0.75    1.88
#   317    355   306     2.16    5.81
#   417    455   406     5.28   14.16
#   517    555   506    10.75   27.72
#   617    655   606    19.15   46.19
#   717    755   706    31.58   74.14
#   817    855   806    46.52  108.05
#   917    955   906    67.94  153.68
#  1017   1055  1006    93.75  207.28

import os, strutils, algorithm, sequtils

type vector = array[3, int]

const meals = [
  [-1, -1,  1],
  [-1,  1, -1],
  [ 1, -1, -1]]

var
  forests = @[[paramStr(1).parseInt(), paramStr(2).parseInt(), paramStr(3).parseInt()]]
  newForests, result: seq[vector] = @[]

while result.len == 0:
  newForests = meals.map(proc(m: vector): seq[vector] =
    forests.map(proc(f: vector): vector =
      [f[0] + m[0], f[1] + m[1], f[2] + m[2]])).concat()
    .filter(proc(x: vector): bool = x[0] >= 0 and x[1] >= 0 and x[2] >= 0)

  newForests.sort(proc(x,y): int =
    for i in 0..2:
      result = x[i] - y[i]
      if result != 0:
        return)

  var last = [-1,-1,-1]
  forests = newForests.filter(proc(x: vector): bool =
    result = x != last; last = x)
  result = forests.filter(proc(x: vector): bool =
    x.map(proc(x): int = result = (if x == 0: 1 else: 0)).foldl(a + b) >= 2)

for i in result:
  echo i[0], ", ", i[1], ", ", i[2]
