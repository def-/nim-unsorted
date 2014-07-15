import unsigned, strutils

type
  TCrc32* = uint32
  TCRC_TabEntry = uint32

const
  InitCrc32* = TCrc32(- 1)

var crc32table: array[0..255, TCRC_TabEntry]

proc updateCrc32(val: int8, crc: TCrc32): TCrc32 = 
  result = TCrc32(crc32table[(int(crc) xor (int(val) and 0x000000FF)) and
      0x000000FF]) xor (crc shr TCrc32(8))

proc updateCrc32(val: char, crc: TCrc32): TCrc32 = 
  result = updateCrc32(toU8(ord(val)), crc)

proc strCrc32(s: string): TCrc32 =
  for i in 0..255:
    var rem = TCRC_TabEntry(i)
    for j in 0..8:
      if (rem and 1) > 0:
        rem = rem shr 1
        rem = rem xor 0xedb88320
      else:
        rem = rem shr 1
      crc32table[i] = rem

  result = InitCrc32
  for c in s:
    result = (result shr 8) xor crc32table[(result and 0xff) xor toU8(ord(c))]

echo "0x",toHex(int64(strCrc32("The quick brown fox jumps over the lazy dog")), 8)
