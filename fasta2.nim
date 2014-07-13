proc handleFasta(header, sequence) =
  echo header.len, " ", sequence.len

var f = system.open("sequence.fasta")
const bufSize = 8192
var
  size = bufSize
  buf {.noinit.}: array[bufSize, char]
  sequence = ""
  header = ""
  afterNewLine = true
  afterNewSeq = false

while size == bufSize:
  size = f.readBuffer(addr buf, bufSize)
  var lastPos = 0
  for i in 0 .. <size:
    if buf[i] == '\l':
      afterNewLine = true
      if afterNewSeq:
        afterNewSeq = false
        header.setLen(i - lastPos)
        copyMem(addr header[0], addr buf[lastPos], i - lastPos)
      else:
        let oldLen = sequence.len
        sequence.setLen(oldLen + i - lastPos)
        copyMem(addr sequence[oldLen], addr buf[lastPos], i - lastPos)
      lastPos = i+1
    elif afterNewLine and buf[i] == '>':
      afterNewLine = false
      afterNewSeq = true
      lastPos = i
      if header != "":
        handleFasta(header, sequence)
        header.setLen(0)
        sequence.setLen(0)

  let oldLen = sequence.len
  sequence.setLen(oldLen + size - lastPos)
  copyMem(addr sequence[oldLen], addr buf[lastPos], size - lastPos)

handleFasta(header, sequence)
