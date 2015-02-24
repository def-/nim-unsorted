import rawsockets, selectors

var data = """HTTP/1.1 200 OK
Content-Length: 11

Hello World"""

var sock = newRawSocket()
sock.setSockOptInt(cint(SOL_SOCKET), SO_REUSEADDR, 1)

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
  sock2 = sock.accept(cast[ptr SockAddr](addr(sockAddress)), addr(addrLen))
  discard sock2.recv(addr incoming, incoming.len, 0)
  discard sock2.send(addr data[0], data.len, int32(MSG_NOSIGNAL))
  sock2.close()

sock.close()
