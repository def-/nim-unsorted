import times, os, strutils

let year = paramStr(1).parseInt
for month in mJan .. mDec:
  for day in countdown(getDaysInMonth(month, year), 1):
    let date = initDateTime(day, month, year, 0, 0, 0, utc())
    if date.weekday == dFri:
      echo date.format "yyyy-MM-dd"
      break
