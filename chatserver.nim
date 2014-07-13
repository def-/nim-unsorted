import asyncnet, asyncdispatch

type TClient = tuple[socket: PAsyncSocket, name: string]
var clients: seq[TClient] = @[]

proc sendOthers(client: TClient, line: string) {.async.} =
  for c in clients:
    if c != client:
      await c.socket.send(line & "\c\L")

proc processClient(socket: PAsyncSocket) {.async.} =
  await socket.send("Please enter your name: ")
  let client: TClient = (socket, await socket.recvLine())

  clients.add client
  client.sendOthers "+++ " & client.name & " arrived +++"

  while true:
    let line = await client.socket.recvLine()
    if line == "":
      client.sendOthers "--- " & client.name & " leaves ---"
      break
    client.sendOthers client.name & "> " & line

  for i,c in clients:
    if c == client:
      clients.del i
      break

proc serve() {.async.} =
  var server = newAsyncSocket()
  server.bindAddr(TPort(4004))
  server.listen()

  while true:
    let socket = await server.accept()
    processClient socket

serve()
runForever()
