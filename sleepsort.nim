import os, posix, strutils

var c = paramCount() + 1
while true:
  dec c
  if c <= 1: break
  if fork() == 0: break

let i = parseInt paramStr c
sleep i
echo i
var pid: cint = 0
discard wait(pid)
