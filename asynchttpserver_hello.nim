import asynchttpserver, asyncdispatch
var server = newAsyncHttpServer()
proc cb(req: Request) {.async.} =
  await req.respond(Http200, "{ \"message\": \"Hello, World!\"}")

asyncCheck server.serve(Port(8000), cb)
runForever()
