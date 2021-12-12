import times

proc germanText*(day: WeekDay): string =
  const lookup: array[WeekDay, string] = ["Montag", "Dienstag", "Mittwoch",
     "Donnerstag", "Freitag", "Samstag", "Sonntag"]
  return lookup[day]

echo "Diary:"
var time = getTime()
for i in 1..7:
  var localTime = local(time)
  echo localTime.format("yyyy-MM-dd"), " ", germanText(localTime.weekday)
  echo "- "
  echo ""
  time += 1.days

echo "Work: "
time = getTime() + 7.days
for i in 1..8:
  var localTime = local(time)
  if localTime.weekday < dSat:
    echo localTime.format("yyyy-MM-dd"), " ", germanText(localTime.weekday), ":"
    echo ""
  time -= 1.days
