import sockets, httpserver

proc handleRequest(client: Socket, path, query: string): bool {.procvar.} =
  client.send("Hello World\n")
  return false # do not stop processing

run(handleRequest, Port(8001))
