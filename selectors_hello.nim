import rawsockets, selectors

type Data* = ref object of RootRef
  socket: SocketHandle

var hw = """HTTP/1.1 200 OK
Content-Length: 11

Hello World"""

var sock = newRawSocket()
sock.setSockOptInt(cint(SOL_SOCKET), SO_REUSEADDR, 1)
sock.setBlocking(false)

var sel = newSelector()
var data = Data(socket: sock)
sel.register(sock, {EvRead, EvWrite}, data)

var name: SockAddr_in
name.sin_family = toInt(AF_INET)
name.sin_port = htons(8080)
name.sin_addr.s_addr = htonl(INADDR_ANY)

discard sock.bindAddr(cast[ptr SockAddr](addr name), Socklen(sizeof(name)))
discard sock.listen()

var
  sockAddress: Sockaddr_in
  addrLen = SockLen(sizeof(sockAddress))
  incoming: array[8192, char]
  sock2: SocketHandle

while true:
  for info in sel.select(1000):
    if EvRead in info.events:
      sock2 = sock.accept(cast[ptr SockAddr](addr(sockAddress)), addr(addrLen))
      discard sock2.recv(addr incoming, incoming.len, 0)
      discard sock2.send(addr hw[0], hw.len, int32(MSG_NOSIGNAL))
      sock2.close()
    elif EvWrite in info.events:
      echo repr(info)

sock.close()
