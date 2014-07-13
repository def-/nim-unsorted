import net

var s = newSocket()
s.connect("localhost", TPort(256))
s.send("Hello Socket World")
s.close()
