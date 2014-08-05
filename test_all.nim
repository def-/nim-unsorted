# in config/nimrod.cfg: cc = gcc
# ./test_all
# ./test_all nimrod --gc:boehm c
# ./test_all nimrod -d:release c
# ./test_all nimrod -d:release --gc:boehm c
#
# in config/nimrod.cfg: cc = clang
# ./test_all
# ./test_all nimrod -d:release c
#
# TODO:
# in config/nimrod.cfg: cc = tcc
# ./test_all
# ./test_all nimrod -d:release c
#
# in config/nimrod.cfg: cc = gcc
# ./test_all nimrod cpp
# ./test_all nimrod -d:release cpp

import unittest, osproc, streams, os, strutils

var compCommand = commandLineParams().join(" ")
if compCommand == "":
  compCommand = "nimrod c"

proc compiles(name: string; params = ""): bool =
  execCmd(compCommand & " --verbosity:0 --warnings:off --hints:off " & params & " " & name & ".nim") == 0

proc returns(name: string; params = ""; input = ""): bool =
  try: removeFile(name)
  except: discard
  if not name.compiles:
    echo "Compilation failed"
    return false
  var p = startProcess(name)
  p.inputStream.write(input)
  p.inputStream.close()
  if p.waitForExit > 0: return false
  if not existsFile(name & ".out"):
    return execProcess("./" & name) == ""
  return p.outputStream.readStr(100000) == readFile(name & ".out")

template testIt(name: string, rest: stmt): stmt {.immediate.} =
  test name:
    let it {.inject.} = name
    rest

discard execCmd("rm -rf nimcache")

testIt "abstract_type": check it.compiles
testIt "accumulatorfactory": check it.returns
testIt "address": check it.compiles
testIt "align": check it.returns
testIt "amb": check it.returns
testIt "anonymousrecursion": check it.returns
testIt "apollonius": check it.returns
testIt "append": check it.compiles
testIt "arr": check it.returns
testIt "ascii3d": check it.returns
testIt "asciialphabet": check it.returns
testIt "assarray": check it.returns
testIt "avg": check it.returns("", "foo\nbar\nfoobar")
testIt "avglooplength": check it.compiles
testIt "balanced": check it.compiles
testIt "beadsort": check it.returns
testIt "bell": check it.returns
testIt "binarydigits": check it.returns
testIt "binarysearch": check it.returns
testIt "binomcoeff": check it.returns
testIt "bitmap": check it.compiles
testIt "bitwise": check it.returns
testIt "bogosort": check it.returns
#testIt "booleanvalues": check it.returns
testIt "bottles": check it.returns
testIt "boxthecompass": check it.returns
testIt "brainfuck": check it.returns("", ">++++++++[<+++++++++>-]<.>>+>+>++>[-]+<[>[->+<<++++>]<<]>.+++++++..+++.>>+++++++.<<<[[-]<[-]>]<+++++++++++++++.>>.+++.------.--------.>>+.>++++.")
testIt "break": check it.returns
testIt "breakoo": check it.returns
testIt "bubblesort": check it.returns
#testIt "bufferedfile": check it.returns
testIt "bullsandcows": check it.compiles
testIt "caesar": check it.returns
testIt "call": check it.returns
testIt "castoutnines": check it.returns
testIt "catalan": check it.returns
testIt "catalannumbers": check it.returns
testIt "catamorphism": check it.compiles
testIt "charcode": check it.returns
testIt "chatserver": check it.compiles
testIt "chineseremainder": check it.returns
testIt "cholesky": check it.returns
testIt "christmas": check it.returns
testIt "classes": check it.returns
testIt "clock": check it.compiles
testIt "closures": check it.returns
testIt "cmdline": check it.compiles
testIt "cocktailsort": check it.returns
testIt "coins": check it.returns
testIt "collections": check it.compiles
testIt "combinations": check it.returns
testIt "combinationsrepetitions": check it.returns
testIt "combsort": check it.returns
testIt "comma": check it.returns
testIt "commondirpath": check it.returns
testIt "compose": check it.returns
testIt "compounddata": check it.compiles
testIt "concarray": check it.compiles
testIt "concurrent2": check it.compiles("--threads:on")
testIt "concurrent3": check it.compiles("--threads:on")
testIt "concurrent": check it.compiles("--passC:\"-fopenmp\" --passL:\"-fopenmp\"")
#testIt "conditionals": check it.compiles
testIt "const": check it.compiles
testIt "contains": check it.compiles
testIt "continue": check it.returns
testIt "conv": check it.returns
testIt "convertradices": check it.returns
testIt "copystring": check it.compiles
testIt "countexamples": check it.compiles
testIt "countinfactors": check it.compiles
testIt "countingsort": check it.returns
testIt "countoccurences": check it.returns
testIt "crc32": check it.returns
testIt "csvtohtml": check it.returns
testIt "curry": check it.returns
testIt "currying": check it.returns
testIt "datemanipulation": check it.returns
testIt "dayoftheweek": check it.returns
testIt "dealcards": check it.returns
testIt "digitalroot": check it.returns
testIt "dininingphilosophers": check it.compiles("--threads:on -d:preventDeadlocks")
testIt "dirempty": check it.compiles
testIt "divzero": check it.returns
testIt "distributedcomputing": check it.compiles
testIt "dns2": check it.compiles
testIt "dns": check it.compiles
testIt "doc": check it.compiles
#testIt "dotproduct": check it.returns # Actually broken right now
testIt "doublyLinkedLists": check it.returns
testIt "dowhile": check it.returns
testIt "drawcuboid": check it.returns
testIt "drawsphere": check it.returns
testIt "dumptree": check it.compiles
testIt "echoserver": check it.compiles
testIt "effects": check it.returns
testIt "empty": check it.compiles
testIt "emptystring": check it.returns
testIt "entropy": check it.returns
testIt "enums": check it.compiles
testIt "env": check it.compiles
testIt "equilibriumindex": check it.returns
testIt "ethiopian": check it.returns
testIt "euler": check it.returns
testIt "evenodd": check it.returns
testIt "evolutionary": check it.compiles
testIt "exceptionnested": check it.compiles
testIt "exceptions": check it.returns
testIt "execsystem": check it.compiles
testIt "exponentialgenerator": check it.returns
testIt "exponentiation": check it.returns
testIt "extendlang": check it.returns
#testIt "extremefloat": check it.returns # Actual bug https://github.com/Araq/Nimrod/pull/1391
testIt "fac2": check it.compiles
testIt "fac": check it.compiles
testIt "factors": check it.returns
testIt "fasta2": check it.compiles
testIt "fasta3": check it.compiles
testIt "fasta4": check it.compiles
testIt "fasta": check it.compiles
testIt "fastaorig": check it.compiles
#testIt "fft": check it.returns # Actual bug https://github.com/Araq/Nimrod/issues/1392
testIt "fibonaccin": check it.returns
testIt "file2": check it.compiles
testIt "file3": check it.compiles
testIt "file4": check it.compiles
testIt "file5": check it.compiles
testIt "fileexists": check it.compiles
testIt "fileinfo": check it.compiles
testIt "file": check it.compiles
testIt "filesize": check it.compiles
testIt "filetape": check it.compiles
testIt "filex": check it.compiles
testIt "filter": check it.returns
testIt "firstclass": check it.returns
testIt "fiveweekends": check it.returns
testIt "flowcontrol": check it.compiles
testIt "floydstriangle": check it.returns
testIt "flushkeyboard": check it.compiles
testIt "forestfire": check it.compiles
testIt "formatnum": check it.returns
testIt "forwarddifference": check it.returns
testIt "fourbitadder": check it.returns
testIt "functionprototype": check it.returns
testIt "game24": check it.compiles
testIt "gameoflife": check it.compiles
testIt "gamma": check it.returns
testIt "globallyreplacetext": check it.compiles
testIt "gltest": check it.compiles
testIt "gnomesort": check it.returns
testIt "gost2814789": check it.returns
testIt "gray": check it.returns
testIt "guessthenumber": check it.compiles
testIt "guessthenumberplayer": check it.compiles
testIt "hailstone2": check it.returns
testIt "hailstone": check it.returns
testIt "happy": check it.returns
testIt "harshad": check it.returns
testIt "hashtwoarrays": check it.compiles
testIt "haversine": check it.returns
testIt "heapsort": check it.returns
testIt "helloerr": check it.compiles
testIt "hellolp": check it.compiles
testIt "hellonew": check it.compiles
testIt "hello": check it.returns
testIt "helloworldgraphical": check it.compiles
testIt "heredoc": check it.returns
testIt "higherorder": check it.returns
testIt "hofstadter": check it.returns
testIt "hofstadterconway": check it.returns
testIt "hofstadterq": check it.returns
testIt "horizontalsundial": check it.compiles
#testIt "horner": check it.returns
testIt "hostintro": check it.compiles
testIt "hostname": check it.compiles
testIt "htmltable": check it.compiles
testIt "http": check it.compiles
testIt "https": check it.compiles("-d:ssl")
testIt "iban": check it.returns
testIt "identitymatrix": check it.returns
#testIt "immutability": check it.returns
testIt "incrementnumstring": check it.returns
testIt "infinite": check it.compiles
#testIt "infinity": check it.returns # Actual bug https://github.com/Araq/Nimrod/pull/1391
testIt "inheritancesingle": check it.returns
testIt "inputloop": check it.compiles
testIt "insertionsort": check it.returns
testIt "intcomp": check it.compiles
testIt "introspection": check it.compiles
testIt "inversevideo": check it.compiles
testIt "iteratorfinished": check it.returns
testIt "jensensdevice": check it.returns
testIt "josephus": check it.returns
testIt "jsons": check it.returns
testIt "kaprekar": check it.returns
testIt "langtonsant": check it.returns
#testIt "largestint": check it.returns # Actually broken
testIt "lastfriday": check it.returns("2013")
testIt "lastsunday": check it.returns("2012")
testIt "lcm": check it.returns
testIt "lcs2": check it.returns
testIt "lcs": check it.returns
testIt "leapyear": check it.returns
testIt "leftfactorials": check it.returns
testIt "letters": check it.compiles
testIt "levenshtein": check it.returns
testIt "linearcongruential": check it.compiles
testIt "linkedlist": check it.returns
testIt "listcomprehensions": check it.returns
testIt "litchar": check it.returns
testIt "litfloat": check it.returns
testIt "litint": check it.returns
testIt "logicop": check it.returns
testIt "longmultiplication": check it.returns
testIt "loopmult": check it.returns
testIt "loop": check it.returns
testIt "lucaslehmertest": check it.returns
testIt "luhntest": check it.returns
testIt "magicsquares": check it.returns
testIt "madlibs": check it.returns("", "She,Monica L.,cockerel\n")
testIt "mail": check it.compiles("-d:ssl")
testIt "manboy": check it.returns
testIt "mandel": check it.returns
testIt "maprange": check it.returns
testIt "matrixarithmetic": check it.returns
testIt "matrixarithmeticseq": check it.returns
#testIt "matrixexponentiation": check it.returns # Actually broken
testIt "matrixmultiplication": check it.returns
testIt "matrixtranspose": check it.returns
testIt "maxlicenses": check it.returns
testIt "maxsum": check it.returns
testIt "maxtrianglepathsum": check it.returns
testIt "mazegeneration": check it.compiles
testIt "md4": check it.returns("-d:ssl")
testIt "meanangle": check it.returns
testIt "mean": check it.returns
testIt "meantime": check it.returns
testIt "median": check it.returns
testIt "memoryalloc": check it.returns
testIt "memorylayout": check it.returns
testIt "menu": check it.compiles
testIt "mergesort": check it.returns
testIt "metaprogramming": check it.returns
testIt "methodcall": check it.returns
testIt "middlethreedigits": check it.returns
testIt "missingpermutation": check it.returns
testIt "mod5": check it.returns
testIt "mode": check it.returns
testIt "modularinverse": check it.returns
testIt "montecarlo": check it.compiles
testIt "montyhall": check it.compiles
testIt "multifactorial": check it.returns
testIt "multipledistinctobjects": check it.returns
testIt "multiplicativeroot": check it.returns
testIt "multisplit": check it.returns
testIt "multtable": check it.returns
testIt "mutex": check it.returns("--threads:on")
testIt "mutrec": check it.returns
testIt "namedparam": check it.returns
#testIt "nil": check it.returns
testIt "noncontsub": check it.returns
testIt "nondecimalradicesinput": check it.returns
testIt "nondecimalradicesoutput": check it.returns
testIt "nosqr": check it.returns
testIt "notes": check it.compiles
#testIt "notnil": check it.compiles
testIt "nqueens": check it.returns
testIt "nth": check it.returns
testIt "nthroot": check it.returns
testIt "numbernames": check it.returns
testIt "numericalintegration": check it.returns
#testIt "objectserial": check it.returns # Actually broken
testIt "oct": check it.compiles
testIt "oddword": check it.compiles
testIt "oldlady": check it.returns
testIt "oneinstane": check it.compiles
testIt "oneofnlines": check it.compiles
testIt "optionalparameters": check it.returns
testIt "opt": check it.returns
testIt "orderedwords": check it.returns
testIt "ordertwolists": check it.returns
testIt "palindrome": check it.returns
testIt "pancakesort": check it.returns
testIt "pangram": check it.compiles
testIt "parametricpolymorphism": check it.compiles
#testIt "parametrizedsql": check it.returns # Actually broken
testIt "pascalstriangle": check it.returns
testIt "permsort": check it.returns
testIt "permutations": check it.returns
testIt "permutationsswap": check it.returns
testIt "playingcards": check it.compiles
testIt "polymorphiccopy": check it.returns
testIt "polymorphism": check it.returns
testIt "powerset": check it.returns
testIt "pow": check it.returns
testIt "prepend": check it.returns
testIt "prepostinc": check it.returns
testIt "preservescreen": check it.compiles
testIt "primality": check it.returns
#testIt "primitive": check it.returns
testIt "priorityqueue": check it.returns
testIt "programname": check it.compiles
testIt "ptrsandrefs": check it.returns
testIt "pythargoreanmeans": check it.returns
# testIt "pythtriples": check it.returns # Recursion without release is limitted...
testIt "quickselect": check it.returns
testIt "quicksort": check it.returns
testIt "quine1": check it.returns
testIt "quine2": check it.returns
testIt "quine": check it.returns
#testIt "randomelement": check it.compiles # Actually broken
testIt "randomcircle": check it.compiles
testIt "ranges": check it.returns
testIt "ranklanguages": check it.compiles
testIt "rational": check it.returns
testIt "realconstfn": check it.returns
testIt "recurse": check it.returns
testIt "recursionlimit": check it.compiles
testIt "reg": check it.returns
testIt "remdup": check it.returns
testIt "rename": check it.compiles
testIt "repstring": check it.returns
testIt "returnmult": check it.returns
testIt "reversalgame": check it.compiles
#testIt "reversednew": check it.returns # Actually broken
testIt "reversed": check it.returns
testIt "reverse": check it.returns
testIt "reversewords": check it.returns
testIt "rngdevice": check it.compiles
testIt "romandec": check it.returns
testIt "romanenc": check it.returns
testIt "rootmean": check it.returns
testIt "rot13": check it.compiles
testIt "rpncalculator": check it.returns
testIt "runlengthenc": check it.returns
testIt "safeadd": check it.returns
testIt "scopemodifiers": check it.returns
testIt "searchlist": check it.compiles
testIt "sedols": check it.returns
testIt "selectionsort": check it.returns
testIt "selfdescribing": check it.returns
testIt "semordnilap": check it.returns
testIt "set": check it.returns
testIt "sha1": check it.returns("-d:ssl")
testIt "sha256": check it.returns("-d:ssl")
testIt "shellsort": check it.returns
testIt "shortcircuit": check it.returns
testIt "showepoch": check it.returns
testIt "shuffle": check it.compiles
testIt "sierpinkski": check it.returns
testIt "sierpinkskicarpet": check it.returns
testIt "sieve": check it.returns
testIt "signals2": check it.compiles
testIt "signals": check it.compiles
testIt "singuser": check it.returns
testIt "simplemovingaverage": check it.returns
testIt "simplewindow": check it.compiles
testIt "sleepsort": check it.compiles
testIt "slice": check it.returns
testIt "sock": check it.compiles
testIt "sortcmp": check it.returns
testIt "sortcomposite": check it.returns
testIt "sortdisjointsublist": check it.returns
testIt "spiralmatrix": check it.returns
testIt "stacks": check it.returns
testIt "stacktraces": check it.compiles
#testIt "stairclimbing": check it.compiles
testIt "statistics": check it.compiles
testIt "stoogesort": check it.returns
testIt "strandsort": check it.returns
testIt "string": check it.returns
testIt "stringnumeric": check it.returns
testIt "stripblockcomments": check it.returns
testIt "stripcomments": check it.returns
testIt "stripcontrolcodes": check it.returns
testIt "strip": check it.returns
testIt "substring": check it.returns
testIt "sum2": check it.returns
testIt "sumdigits": check it.returns
testIt "summultiples": check it.returns
testIt "sum": check it.returns
testIt "sumseries": check it.returns
testIt "sumsquares": check it.returns
testIt "symmetricdifference": check it.returns
testIt "tablecreation": check it.returns
testIt "temperature": check it.compiles
testIt "termclear": check it.compiles
testIt "termcolor": check it.returns
testIt "termcursorpos": check it.returns
testIt "termextendchar": check it.returns
testIt "tests2": check it.compiles
testIt "tests": check it.returns
testIt "textproc1": check it.returns
testIt "timefunction": check it.compiles
testIt "tokenize": check it.returns
testIt "topranks": check it.returns
testIt "totalcirclearea": check it.returns
testIt "trabb_pardo_knuth": check it.returns("", "1 2 3 4 5 6 7 8 9 10 11")
testIt "treelist": check it.returns
testIt "treetrav": check it.returns
testIt "trigonom": check it.returns
testIt "tr": check it.returns
testIt "truncatableprimes": check it.returns
testIt "truncate": check it.returns
testIt "tupleassign": check it.returns
testIt "turingmachine": check it.returns
testIt "twod": check it.compiles
testIt "typeclass": check it.returns
testIt "typename": check it.returns
testIt "unbiasrandom": check it.compiles
testIt "unicodeoutput": check it.compiles
testIt "unicodestrings": check it.returns
testIt "unimplementedtasks": check it.compiles
testIt "urldecode": check it.returns
testIt "urlencode": check it.returns
testIt "userinput": check it.compiles
testIt "variablesizeget": check it.returns
testIt "variablesizeset": check it.returns
testIt "variadic": check it.returns
testIt "varlenquantity": check it.returns
testIt "vars": check it.returns
#testIt "vectorprod": check it.returns # Actually broken
testIt "vigenere": check it.returns
testIt "visualizetree": check it.returns
testIt "walknonrec": check it.returns
testIt "walkrec": check it.compiles
testIt "wcl": check it.compiles
testIt "webscraping": check it.compiles # Website down
testIt "webserver": check it.compiles
testIt "wordwrap": check it.returns
testIt "xmlin": check it.returns
testIt "xmlout": check it.returns
testIt "xml_dom": check it.returns
testIt "xmlxpath": check it.returns
testIt "zeckendorf": check it.returns
testIt "zeropowzero": check it.returns
testIt "zigzagmatrix": check it.returns
