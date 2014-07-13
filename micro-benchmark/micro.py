size = 100000000
a = [None] * size
for i in range(len(a)):
  a[i] = i

sum = 0
for x in a:
  sum += x
print(sum)
