import memfiles

var
  f = memfiles.open("sequence.fasta")
  fastas: seq[tuple[header: string; seqStart, seqLen: int]] = @[]
  afterNewLine = true
  afterNewSeq = false
  header = ""
  lastPos = 0
  i = 0
  seqStart = 0

for c in cast[cstring](f.mem):
  if c == '\l':
    if afterNewSeq:
      header.setLen(i - lastPos - 1)
      copyMem(addr header[0], cast[pointer](cast[int](f.mem) + lastPos + 1), i - lastPos - 1)
      afterNewSeq = false
      seqStart = i + 1
    afterNewLine = true
  elif c == '>':
    if seqStart > 0:
      fastas.add((header, seqStart, i - seqStart - 1))
    afterNewLine = false
    afterNewSeq = true
  else:
    afterNewLine = false
  inc(i)
fastas.add((header, seqStart, i - seqStart - 1))

echo fastas
