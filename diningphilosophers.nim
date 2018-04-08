import locks, random, os
randomize()

type Philosopher = ref object
  name: string
  forkLeft, forkRight: int

const
  n = 5
  names = ["Aristotle", "Kant", "Spinoza", "Marx", "Russell"]

var
  forks: array[n, Lock]
  phils: array[n, Philosopher]
  threads: array[n, Thread[Philosopher]]

proc run(p: Philosopher) {.thread.} =
  while true:
    sleep rand 1 .. 9
    echo p.name, " is hungry."

    acquire forks[min(p.forkLeft, p.forkRight)]
    sleep rand 1 .. 4
    acquire forks[max(p.forkLeft, p.forkRight)]

    echo p.name, " starts eating."
    sleep rand 1 .. 9

    echo p.name, " finishes eating and leaves to think."

    release forks[p.forkLeft]
    release forks[p.forkRight]

for i in 0 ..< n:
  initLock forks[i]

for i in 0 ..< n:
  phils[i] = Philosopher(name: names[i],
    forkLeft: i,
    forkRight: (i+1) mod n)

for i in 0 ..< n:
  threads[i].createThread run, phils[i]

threads.joinThreads
