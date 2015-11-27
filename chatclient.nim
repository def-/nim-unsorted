import net, os

proc stdinLoop(socket: Socket) {.thread.} =
  while true:
    let input = stdin.readLine()
    socket.send(input & "\c\L")

proc socketLoop(socket: Socket) =
  var output = ""
  while true:
    let read = socket.recv(output, 1)

    if read == 0:
      echo "Connection closed by server"
      return

    stdout.write output
    flushFile stdout

if paramCount() != 1:
  echo "Usage: ", getAppFilename(), " server"
  quit QuitFailure

var
  socket = newSocket(buffered = false)
  thread: Thread[Socket]

socket.connect(paramStr(1), Port 4004)
thread.createThread(stdinLoop, socket)
socket.socketLoop()
