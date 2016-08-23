import httpclient, strutils, xmldom, xmldomparser, cgi

proc count(s, sub: string): int =
  var i = 0
  while true:
    i = s.find(sub, i)
    if i < 0:
      break
    inc i
    inc result

const
  mainSite = "http://www.rosettacode.org/w/api.php?action=query&list=categorymembers&cmtitle=Category:Programming_Tasks&cmlimit=500&format=xml"
  subSite = "http://www.rosettacode.org/w/index.php?title=$#&action=raw"

var sum = 0

for i in getContent(mainSite).loadXML().getElementsByTagName("cm"):
  let t = PElement(i).getAttribute("title").replace(" ", "_")
  let content = getContent(subSite % encodeUrl(t)).toLowerAscii()
  let c = content.count("{{header|")
  let nim = if content.count("{{header|nimrod}}") == 0: " [NIMROD MISSING]" else: ""
  echo c," examples for ",t.replace("_", " "),nim
  sum += c

echo "\nTotal: ",sum," examples."
