import math, strutils

type ypFunc = proc(t, y: float64): float64
type ypStepFunc = proc(t, y, dt: float64): float64

# newRKStep takes a function representing a differential equation
# and returns a function that performs a single step of the forth-order
# Runge-Kutta method.
proc newRK4Step(yp: ypFunc): ypStepFunc =
   return proc(t, y, dt: float64): float64 =
      var dy1 = dt * yp(t, y)
      var dy2 = dt * yp(t+dt/2, y+dy1/2)
      var dy3 = dt * yp(t+dt/2, y+dy2/2)
      var dy4 = dt * yp(t+dt, y+dy3)
      return y + (dy1+2*(dy2+dy3)+dy4)/6

# example differential equation
proc yprime(t, y: float64): float64 =
   return t * sqrt(y)

# exact solution of example
proc actual(t: float64): float64 =
   var t = t*t + 4
   return t * t / 16

template ff(f: float): string =
   formatFloat(f, ffDefault, -1)

template printErr(t, y: float64): untyped =
   echo "y($#) = $# Error: $#" % [ff(t), ff(y), ff(abs(actual(t)-y))]

proc main() =
   let (t0, tFinal) = (0, 10)  # task specifies times as integers,
   let dtPrint = 1         # and to print at whole numbers.
   var y0 = 1.0            # initial y.
   let dtStep = 0.1        # step value.

   var (t, y) = (float64(t0), y0)
   var ypStep = newRK4Step(yprime)
   for t1 in countup(t0 + dtPrint, tFinal, dtPrint):
      printErr(t, y) # print intermediate result
      for steps in countdown(int(float64(dtPrint)/dtStep + 0.5), 2):
         y = ypStep(t, y, dtStep)
         t += dtStep

      y = ypStep(t, y, float64(t1)-t) # adjust step to integer time
      t = float64(t1)

   printErr(t, y) # print final result

main()
