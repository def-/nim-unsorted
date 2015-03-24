import httpclient, json, re, strutils, algorithm, future

type Rank = tuple[lang: string, count: int]

const
  langSite = "http://www.rosettacode.org/w/api.php?action=query&list=categorymembers&cmtitle=Category:Programming_Languages&cmlimit=500&format=json"
  catSize = "http://www.rosettacode.org/w/index.php?title=Special:Categories&limit=5000"
let regex = re"title=""Category:(.*?)"">.+?</a>.*\((.*) members\)"

var langs = newSeq[string]()
for l in parseJson(getContent(langSite))["query"]["categorymembers"]:
  try: langs.add(l["title"].str.split("Category:")[1])
  except: discard

var ranks = newSeq[Rank]()
for line in getContent(catSize).findAll(regex):
  let lang = line.replacef(regex, "$1")
  if lang in langs:
    let count = parseInt(line.replacef(regex, "$2").strip())
    ranks.add((lang, count))

ranks.sort((x: Rank, y: Rank) => cmp[int](y.count, x.count))
for i, l in ranks:
  echo align($(i+1), 3), align($l.count, 5), " - ", l.lang
