var a: array[100, int]
var b: array[50, int]

for i in 0..99:
  a[i] = 100-i
b[10..20] = a[30..40]

for i in b:
  echo i
