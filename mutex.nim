# Compile with nim --threads:on c mutex
import locks

# Creating a mutex:
var mutex: Lock
initLock mutex

# Locking:
acquire mutex

# Unlocking:
release mutex

# Trying to lock (but do not wait if it can't)
let success = tryAcquire mutex
