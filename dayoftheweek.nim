import times

var timeinfo = getTime().local
timeinfo.monthday = 25
timeinfo.month = mDec
for year in 2008..2121:
  timeinfo.year = year
  if timeinfo.toTime.local.weekday == dSun:
    stdout.write year," "
echo ""
