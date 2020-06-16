import times

proc doWork(x: int) =
  var n = x
  for i in 0..10000000:
    n += i

template time(s): untyped =
  let t0 = cpuTime()
  s
  cpuTime() - t0

echo time(doWork(100))
