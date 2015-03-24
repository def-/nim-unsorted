proc record(bytes: int): seq[int8] =
  var f = open("/dev/dsp")
  result = newSeq[int8](bytes)
  discard f.readBytes(result, 0, bytes)

proc play(buf: seq[int8]) =
  var f = open("/dev/dsp", fmWrite)
  f.write(buf)
  f.close

var p = record(65536)
play(p)
