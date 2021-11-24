proc fgets(c: cstring, n: int, f: File): cstring {.
  importc: "fgets", header: "<stdio.h>", tags: [ReadIOEffect].}

proc myReadLine(f: File, line: var string): bool =
  var buf {.noinit.}: array[8192, char]
  setLen(line, 0)
  result = true
  while true:
    if fgets(cstring(addr buf), 8192, f) == nil:
      result = false
      break
    if buf[cstring(addr buf).len-1] == '\l':
      buf[cstring(addr buf).len-1] = '\0'
      add(line, cstring(addr buf))
      break
    add(line, cstring(addr buf))

proc handleFasta(header, sequence: string) =
  echo header.len, " ", sequence.len

var sequence = ""
var header = ""
var seq_index = -1
var line = ""
var f = open("sequence.fasta")
while f.myReadLine(line):
  if line[0] == '>':
    if seq_index >= 0:
      handleFasta(header, sequence)
    header = line
    sequence.setLen(0)
    seq_index += 1
  else:
    sequence.add(line)
handleFasta(header, sequence)
