import math, complex, strutils

#const mpi: cdouble = 3.14159265358979323846

proc rect(r, phi): TComplex = (r * cos(phi), sin(phi))
proc phase(c): float = arctan2(c.im, c.re)

proc radians(x): float = (x * pi) / 180.0
proc degrees(x): float = (x * 180.0) / pi

proc meanAngle(deg): float =
  var c: TComplex
  for d in deg:
    c = c + rect(1.0, radians(d))
  degrees(phase(c / float(deg.len)))

#proc meanAngle(angles): float =
#  var c: TComplex
#  for d in angles:
#    c = c + rect(1.0, radians(d))
#    echo c
#
#  echo (c / float(angles.len))
#  echo phase(c / float(angles.len))
#  degrees(phase(c / float(angles.len)))

#proc meanAngle(angles): cdouble =
#  var xPart, yPart: cdouble = 0
#  for i in 0 .. < angles.len:
#    echo cos(angles[i] * pi / 180)
#    xPart += cos(angles[i] * pi / 180)
#    yPart += sin(angles[i] * pi / 180)
#    echo angles[i], " ", xPart, " ", yPart
#  echo yPart / float(angles.len), " ", xPart / float(angles.len)
#  echo arctan2(yPart / float(angles.len), xPart / float(angles.len))
#  arctan2(yPart / float(angles.len), xPart / float(angles.len)) * 180 / pi

echo "The 1st mean angle is: ", formatFloat(meanAngle([350.0, 10.0]), ffDecimal, 1), " degrees"
echo "The 2nd mean angle is: ", formatFloat(meanAngle([90.0, 180.0, 270.0, 360.0]), ffDecimal, 1), " degrees"
echo "The 3rd mean angle is: ", formatFloat(meanAngle([10.0, 20.0, 30.0]), ffDecimal, 1), " degrees"
