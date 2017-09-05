# http://unriskinsight.blogspot.de/2014/06/fast-functional-goats-lions-and-wolves.html
#
# Goats Wolves Lions    C++11  Nimrod
#    17     55     6     0.00    0.03
#   117    155   106     0.17    0.13
#   217    255   206     0.75    0.62
#   317    355   306     2.16    1.89
#   417    455   406     5.28    4.34
#   517    555   506    10.75    8.42
#   617    655   606    19.15   14.45
#   717    755   706    31.58   23.04
#   817    855   806    46.52   33.69
#   917    955   906    67.94   48.57
#  1017   1055  1006    93.75   65.25
#  2017   2055  2006   731.42  500.95

import os, strutils, algorithm

type vector = array[3, int]

const meals = [
  [-1, -1,  1],
  [-1,  1, -1],
  [ 1, -1, -1]]

proc cmp(x, y: vector): int =
  for i in 0..2:
    result = x[i] - y[i]
    if result != 0:
      return

proc solve(forests: var seq[vector]): seq[vector] =
  var newForests: seq[vector] = @[]
  var last = [-1,-1,-1]

  result = @[]

  while result.len == 0:
    for meal in meals:
      for forest in forests:
        let f = [forest[0] + meal[0], forest[1] + meal[1], forest[2] + meal[2]]
        if f[0] >= 0 and f[1] >= 0 and f[2] >= 0:
          newForests.add(f)

    newForests.sort(cmp)

    forests.setLen(0)

    for forest in newForests:
      if forest != last:
        forests.add(forest)
      last = forest

    for forest in forests:
      var count = 0
      for animal in forest:
        if animal == 0:
          count += 1

      if count >= 2:
        result.add(forest)

    newForests.setLen(0)

var f = @[[paramStr(1).parseInt(), paramStr(2).parseInt(), paramStr(3).parseInt()]]
for i in solve(f):
  echo i[0], ", ", i[1], ", ", i[2]
