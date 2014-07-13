import strutils

proc wordWrap2*(s: string, maxLineWidth = 80,
               splitLongWords = true,
               seps: set[char] = Whitespace,
               newLine = "\n"): string =
  ## word wraps `s`.
  result = newStringOfCap(s.len + s.len shr 6)
  var spaceLeft = maxLineWidth
  var lastSep = ""
  for word, isSep in tokenize(s, seps):
    if isSep:
      lastSep = word
      spaceLeft = spaceLeft - len(word)
      continue
    if len(word) > spaceLeft:
      if splitLongWords and len(word) > maxLineWidth:
        result.add(substr(word, 0, spaceLeft-1))
        var w = spaceLeft+1
        var wordLeft = len(word) - spaceLeft
        while wordLeft > 0:
          result.add(newLine)
          var L = min(maxLineWidth, wordLeft)
          spaceLeft = maxLineWidth - L
          result.add(substr(word, w, w+L-1))
          inc(w, L)
          dec(wordLeft, L)
      else:
        spaceLeft = maxLineWidth - len(word)
        result.add(newLine)
        result.add(word)
    else:
      spaceLeft = spaceLeft - len(word)
      result.add(lastSep & word)
      lastSep.setLen(0)


let txt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus. Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit. Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue. Nam tincidunt congue enim, ut porta lorem lacinia consectetur."
echo wordWrap2(txt)
echo ""
echo wordWrap2(txt, 45)
