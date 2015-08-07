var
  i32: int32
  i64: int64
  u32: uint32
  u64: uint64

echo "Signed 32-bit:"

i32 = -2147483647
echo(-(i32 - 1))

i32 = 2000000000
echo(i32 + i32)

i32 = -2147483647
echo(i32 + i32)

i32 = 46341
echo(i32 * i32)

i32 = -2147483647
echo((i32-1) div -1)

echo "Signed 64-bit:"

i64 = -9223372036854775807
echo(-(i64 - 1))

i64 = 5000000000000000000
echo(i64 + i64)

i64 = -9223372036854775807
echo(i64 + i64)

i64 = 3037000500
echo(i64 * i64)

i64 = -9223372036854775807
echo((i64-1) div -1)

echo "Unsigned 32-bit:"

#u32 = -4294967295 # Compile time error
#u32 = 4294967295'u32 # TODO: This should work without the literal
#echo(-u32) # Compile time error

u32 = 3000000000'u32 # TODO: This should work without the literal
echo(u32 + u32)

var a: uint32 = 2147483647
u32 = 4294967295'u32
echo(a - u32)

u32 = 65537
echo(u32 * u32)

echo "Unsigned 64-bit:"

#u64 = 18446744073709551615'u64 # TODO: This should work
#echo(-u64)

#u64 = 10000000000000000000'u64 # TODO: This should work
#echo(u64 + u64)

#var aa: uint64 = 9223372036854775807'u64 # TODO: This should work without the literal
#u64 = 18446744073709551615'u64 # TODO: This should work
#echo(aa - u64)

u64 = 4294967296'u64 # This should work without the literal
echo(u64 * u64)
