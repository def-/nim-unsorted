import osproc, os
discard execCmd "stty raw"

sleep 5000
flushFile stdin # Not working =/
echo stdin.readChar

discard execCmd "stty cooked"
