import nativesockets
var infos = getAddrInfo("ddnet.tw", Port 80)

var info = infos
while info != nil:
  echo infos.ai_flags
  echo infos.ai_family
  echo infos.ai_socktype
  echo infos.ai_protocol
  echo infos.ai_addrlen
  echo infos.ai_addr[]
  let len = int(infos.ai_addrlen)
  for i in 0 ..< len:
    echo int(infos.ai_addr[].sa_data[i])
  if infos.ai_canonname != nil:
    echo infos.ai_canonname
  info = info.ai_next

freeAddrInfo(infos)
