import httpclient, strutils, xmldom, xmldomparser, cgi, os

proc count(s, sub): int =
  var i = 0
  while true:
    i = s.find(sub, i)
    if i < 0:
      break
    inc i
    inc result

proc findrc(category): seq[string] =
  var
    name = "http://www.rosettacode.org/w/api.php?action=query&list=categorymembers&cmtitle=Category:$#&cmlimit=500&format=xml" % encodeUrl(category)
    cmcontinue = @[""]
    titles = newSeq[string]()

  while true:
    var x = getContent(name&cmcontinue[0]).loadXML()
    for i in x.getElementsByTagName("cm"):
      titles.add PElement(i).getAttribute("title")

    cmcontinue = @[]
    for i in x.getElementsByTagName("categorymembers"):
      let u = PElement(i).getAttribute("cmcontinue")
      if u != nil: cmcontinue.add encodeUrl(u)

    if cmcontinue.len > 0:
      cmcontinue[0] = "&cmcontinue=" & cmcontinue[0]
    else:
      break

  return titles

let alltasks = findrc("Programming_Tasks")
let lang = findrc(paramStr(1))

for i in alltasks:
  if i notin lang:
    echo i
