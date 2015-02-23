import json

var j = %* [{"name": "John", "age": 30}, {"name": "Susan", "age": 31}]
echo j

var j2 = %*
  [
    {
      "name": "John",
      "age": 30
    },
    {
      "name": "Susan",
      "age": 31
    }
  ]
echo j2

var name = "John"
let herAge = 30
const hisAge = 31

var j3 = %*
  [ { "name": "John"
    , "age": herAge
    }
  , { "name": "Susan"
    , "age": hisAge
    }
  ]
echo j3
