proc changes(amount: int, coins: openarray[int]): int64 =
  var ways = @[1'i64]
  ways.setLen(amount+1)
  for coin in coins:
    for j in coin..amount:
      ways[j] += ways[j-coin]
  ways[amount]

echo changes(100, [1, 5, 10, 25])
echo changes(100000, [1, 5, 10, 25, 50, 100])
