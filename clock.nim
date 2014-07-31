import times, os

const
  t = ["⡎⢉⢵","⠀⢺⠀","⠊⠉⡱","⠊⣉⡱","⢀⠔⡇","⣏⣉⡉","⣎⣉⡁","⠊⢉⠝","⢎⣉⡱","⡎⠉⢱","⠀⠶⠀"]
  b = ["⢗⣁⡸","⢀⣸⣀","⣔⣉⣀","⢄⣀⡸","⠉⠉⡏","⢄⣀⡸","⢇⣀⡸","⢰⠁⠀","⢇⣀⡸","⢈⣉⡹","⠀⠶ "]

using stdout
while true:
  let x = getClockStr()
  write "\e[H\e[J"
  for c in x: write t[c.ord - '0'.ord]
  echo ""
  for c in x: write b[c.ord - '0'.ord]
  echo ""
  sleep 1000
