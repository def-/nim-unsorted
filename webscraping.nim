import httpclient, strutils

for line in newHttpClient().getContent("http://tycho.usno.navy.mil/cgi-bin/timer.pl").splitLines:
  if " UTC" in line:
    echo line[4..line.high]
