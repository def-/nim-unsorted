import httpclient, strutils, json, re, os

## This code was used to convert all mentions of Nimrod to Nim on Rosetta Code
## automatically.

const
  loginPage     = "http://rosettacode.org/mw/api.php?action=login"
  categoryPage  = "http://rosettacode.org/mw/api.php?action=query&" &
    "list=categorymembers&cmtitle=Category:$#&cmlimit=500&format=json"
  rawActionPage = "http://rosettacode.org/wiki/$#?action=raw"
  editTokenPage = "http://rosettacode.org/mw/api.php?action=query&" &
    "intoken=edit&titles=$#&format=json&prop=info"
  postPage      = "http://rosettacode.org/mw/api.php?action=edit"

if commandLineParams().len != 2:
  echo "Invalid parameters, username and password expected"
  quit(1)

let
  user = commandLineParams()[0]
  pass = commandLineParams()[1]
  lang = "Nimrod"
  regs = [(re"Nimrod", "Nim"), (re"nimrod", "nim")]
  desc = "Nimrod -> Nim"

var
  loginData   = newMultipartData(
    {"action": "login", "format": "json", "lgname": user, "lgpassword": pass})
let
  # Need to get a token first
  loginTJson  = postContent(loginPage, multipart = loginData).parseJson()
  loginTToken = loginTJson["login"]["token"].str
  loginTId    = loginTJson["login"]["sessionid"].str

  cookies     = "Cookie: rosettacodeToken=$#; rosettacode_session=$#\c\L"
                .format(loginTToken, loginTId)

loginData["lgtoken"] = loginTToken

let
  # Now really log in
  loginJson = postContent(loginPage, cookies, multipart = loginData).parseJson()

if loginJson["login"]["result"].str != "Success":
  raise newException(ValueError, "Login failed")

let
  loginToken  = loginJson["login"]["lgtoken"].str
  loginId     = loginJson["login"]["sessionid"].str
  userName    = loginJson["login"]["lgusername"].str
  userId      = loginJson["login"]["lguserid"].num

  # List of all titles that exist for our language
  titlesJson  = getContent(categoryPage % lang).parseJson()

for catMember in titlesJson["query"]["categorymembers"]:
  let
    title     = catMember["title"].str
    uriTitle  = title.replace(' ', '_')
    newText   = getContent(rawActionPage % uriTitle).parallelReplace(regs)

    # Would be nice to keep track of cookies automatically in a higher level
    # HTTP client library
    cookies   = ("Cookie: rosettacodeToken=$#; rosettacode_session=$#; " &
                 "rosettacodeUserName=$#; rosettacodeUserID=$#\c\L")
                 .format(loginToken, loginId, userName, userId)

    # Get a token so that we're allowed to edit the page
    tokenJson = getContent(editTokenPage % uriTitle, cookies).parseJson()
    editToken = tokenJson["query"]["pages"].fields[0].val["edittoken"].str

    editData = newMultipartData(
      {"action": "edit", "format": "json", "summary": desc,
       "title": uriTitle, "text": newText, "token": editToken})

  # Finally edit the page, print the result
  echo postContent(postPage, cookies, multipart = editData)
