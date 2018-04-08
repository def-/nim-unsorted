import times

const LongMonths = {mJan, mMar, mMay, mJul, mAug, mOct, mDec}

var timeinfo = getTime().local
timeinfo.monthday = 1

var sumNone = 0
for year in 1900..2100:
  var none = true
  for month in LongMonths:
    timeinfo.year = year
    timeinfo.month = month
    if timeinfo.toTime.local.weekday == dFri:
      echo month," ",year
      none = false
  if none: inc sumNone
echo "Years without a 5 weekend month: ",sumNone
