# Using a local buffer, slower unfortunately
# But fgets does not regard CR, so this is different from readLine
# Same as Python though

proc fgets(c: cstring, n: int, f: TFile): cstring {.
  importc: "fgets", header: "<stdio.h>", tags: [FReadIO].}

proc myReadLine(f: TFile, line: var TaintedString): bool =
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

# compute average line length
var count = 0
var sum = 0

var line = ""
while stdin.myReadLine(line):
  count += 1
  sum += line.len

echo "Average line length: ",
  if count > 0: sum / count else: 0
