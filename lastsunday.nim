import times, os, strutils

let year = paramStr(1).parseInt
for month in mJan .. mDec:
  for day in countdown(getDaysInMonth(month, year), 1):
    let t = getGMTime toTime TimeInfo(second: 0, minute: 0, hour: 12,
      monthday: day, month: month, year: year, timezone: 0)
    if t.weekday == dSun:
      echo t.format "yyyy-MM-dd"
      break
