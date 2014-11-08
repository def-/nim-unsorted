import httpserver, sockets

proc handleRequest(client, path, query): bool =
  client.send("Goodbye, World!")
  false

run(handleRequest, Port(8080))
