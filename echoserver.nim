import asyncnet, asyncdispatch

proc processClient(client: PAsyncSocket) {.async.} =
  while true:
    let line = await client.recvLine()
    await client.send(line & "\c\L")

proc serve() {.async.} =
  var server = newAsyncSocket()
  server.bindAddr(TPort(12321))
  server.listen()

  while true:
    let client = await server.accept()
    processClient(client)

serve()
runForever()
