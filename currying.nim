proc addN[T](n: T): auto = (proc(x: T): T = x + n)

let add2 = addN(2)
echo add2(7)

import sugar

proc addM[T](n: T): auto = (x: T) => x + n

let add3 = addM(3)
echo add3(7)
