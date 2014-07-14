import db_sqlite as db
#import db_mysql as db
#import db_postgres as db

const
  connection = ":memory:"
  user = "foo"
  pass = "bar"
  database = "db"

var c = open(connection, user, pass, database)
using c

# Setup
exec sql"create temp table players (name, score, active, jerseyNum)"
exec sql"insert into players values ('name',0,'false',99)"
exec sql"insert into players values ('name',0,'false',100)"

# Demonstrate parameterized SQL
exec sql"update players set name=?, score=?, active=? where jerseyNum=?", "Smith, Steve", 42, true, 99
#exec sql"update players set name=?, score=?, active=? where jerseyNum=99", "Smith, Steve", 42, true # This works

for row in getAllRows sql"select * from players":
  echo row

close()
