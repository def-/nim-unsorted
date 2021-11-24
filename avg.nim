# Using a local buffer, slower unfortunately
# But fgets does not regard CR, so this is different from readLine
# Same as Python though

proc fgets(c: cstring, n: int, f: File): cstring {.
  importc: "fgets", header: "<stdio.h>", tags: [ReadIOEffect].}

proc getc(stream: File): cint {.importc: "getc", header: "<stdio.h>",
  tags: [ReadIOEffect].}

proc getc_unlocked(stream: File): cint {.importc: "getc_unlocked", header: "<stdio.h>",
  tags: [ReadIOEffect].}

proc ungetc(c: cint, f: File) {.importc: "ungetc", header: "<stdio.h>",
  tags: [].}

proc myReadLine2(f: File, line: var string): bool =
  # of course this could be optimized a bit; but IO is slow anyway...
  # and it was difficult to get this CORRECT with Ansi C's methods
  setLen(line, 0) # reuse the buffer!
  while true:
    var c = getc_unlocked(f)
    if c < 0'i32:
      if line.len > 0: break
      else: return false
    if c == 10'i32: break # LF
    if c == 13'i32:  # CR
      c = getc_unlocked(f) # is the next char LF?
      if c != 10'i32: ungetc(c, f) # no, put the character back
      break
    add line, chr(int(c))
  result = true

proc myReadLine(f: File, line: var string): bool =
  var buf {.noinit.}: array[8192, char]
  setLen(line, 0)
  result = true
  while true:
    if fgets(cstring(addr buf), 8192, f) == nil:
      result = false
      break
    let l = cstring(addr buf).len-1
    if buf[l] == '\l':
      buf[l] = '\0'
      add(line, cstring(addr buf))
      break
    add(line, cstring(addr buf))

# compute average line length
var count = 0
var sum = 0

var line = ""
#while stdin.readLine(line):
#while stdin.myReadLine(line):
while stdin.myReadLine2(line):
  count += 1
  sum += line.len

echo "Average line length: ",
  if count > 0: sum / count else: 0
