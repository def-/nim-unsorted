import times

var timeinfo = getTime().local
timeinfo.monthdayZero = 25
timeinfo.monthZero = int(mDec)
for year in 2008..2121:
  timeinfo.year = year
  if timeinfo.toTime.local.weekday == dSun:
    stdout.write year," "
echo ""
