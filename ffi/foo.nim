{.compile: "hi.c".}
proc hi(name: cstring) {.importc: "chi".}
hi("GPN14")

proc printf(formatstr: cstring)
  {.header: "<stdio.h>", varargs.}

var x = "foo"
printf("Hello %d %s!\n", 12, x)

const Δ = 12

echo Δ
