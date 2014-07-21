import rawsockets
echo getHostByName("google.com")
echo getHostByName("ddnet.tw")
for i in getHostByName("ddnet.tw").addrList:
  var s = ""
  for c in i:
    if s != "": s.add('.')
    s.add($int(c))
  echo s
