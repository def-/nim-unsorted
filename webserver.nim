import httpserver, sockets

proc handleRequest(client, path, query): bool =
  client.send("Goodbye, World!")
  false

run(handleRequest, TPort(8080))
