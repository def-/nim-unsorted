import os
let accTime = getLastAccessTime("filename")
let modTime = getLastModificationTime("filename")

import posix, times
var unixAccTime = Timeval(tv_sec: posix.Time(toUnix(accTime)))
var unixModTime = Timeval(tv_sec: posix.Time(toUnix(modTime)))

# Set the modification time
unixModTime.tv_sec = posix.Time(0)

var times2 = [unixAccTime, unixModTime]
discard utimes("filename", addr(times2))

# Set the access and modification times to the current time
discard utimes("filename", nil)
