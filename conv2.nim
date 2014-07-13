type dice = range[0..5]
var d: dice = 4
#d = 6 # error: out of range

var ds: array['a'..'z', dice]
ds['d'] = 5

for d in ds:
  echo d
#ds['D'] = 0 # error: index out of bounds

var newDs: seq[dice] = @[]
for i,d in ds:
  if i > 'd' and d == 5:
    newDs.add(d)
echo newDs

proc addInt(a, b: int): int =
  asm """
    "addl %%ecx, %%eax\n"
    "jno 1\n"
    "call `raiseOverflow`\n"
    "1: \n"
    :"=a"(`result`)
    :"a"(`a`), "c"(`b`)
  """

echo addInt(2,3)
