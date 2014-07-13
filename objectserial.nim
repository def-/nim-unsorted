import streams, marshal

type
  Entity = object of TObject
    name: string

  Person = object of Entity
    age: int

proc printName(x: Entity) =
  echo x.name

var instance1 = Person(name: "Cletus", age: 12)
echo repr(instance1)
instance1.printName()

var instance2 = Entity(name: "Entity")
instance2.printName()

var target = newFileStream(open("objects.dat", fmWrite))
target.store(instance1)
target.store(instance2)
target.close()

target = newFileStream(open("objects.dat", fmRead))
var i1: Person
target.load(i1)
var i2: Entity
target.load(i2)

i1.printName()
i2.printName()
