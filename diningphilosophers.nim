import os, math, locks
randomize()

type Philosopher = tuple
  name: string
  forkLeft, forkRight: TLock

proc run(p: ptr Philosopher) {.thread.} =
  while true:
    sleep random 3_000 .. 13_000
    echo p.name, " is hungry."

    acquire p.forkLeft
    acquire p.forkRight

    echo p.name, " starts eating."
    sleep random 1_000 .. 10_000
    echo p.name, " finishes eating and leaves to think."

    release p.forkLeft
    release p.forkRight

const
  number = 5
  names: array[number, string] =
    ["Aristotle", "Kant", "Spinoza", "Marx", "Russell"]

var
  forks: array[number, TLock]
  phils: array[number, Philosopher]
  threads: array[number, TThread[ptr Philosopher]]

for i in 0 .. <number: initLock forks[i]
for i in 0 .. <number: phils[i] = (names[i], forks[i], forks[(i+1) mod 5])
for i in 0 .. <number: threads[i].createThread run, addr phils[i]

threads.joinThreads
