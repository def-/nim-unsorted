proc fgets(c: cstring, n: int, f: File): cstring {.
  importc: "fgets", header: "<stdio.h>", tags: [ReadIOEffect].}

proc myReadLine(f: File, line: var TaintedString): bool =
  var buf {.noinit.}: array[8192, char]
  setLen(line.string, 0)
  result = true
  while true:
    if fgets(buf, 8192, f) == nil:
      result = false
      break
    if buf[cstring(buf).len-1] == '\l':
      buf[cstring(buf).len-1] = '\0'
      add(line, cstring(buf))
      break
    add(line, cstring(buf))

iterator fasta_pairs*(f: File): tuple[header: string, sequence: string] =
  #var sequence = newStringOfCap(15_000_000) # If you know the approximate size beforehand
  var sequence = ""
  var header = ""
  var seq_index = -1
  var line = ""
  while f.myReadLine(line):
    if line[0] == '>':
      if seq_index >= 0:
        yield (header, sequence)
      header = line
      sequence.setLen(0)
      seq_index += 1
    else:
      sequence.add(line)
  yield (header, sequence)

var f = open("sequence.fasta")
for i in fasta_pairs(f):
  echo i[0].len, " ", i[1].len
