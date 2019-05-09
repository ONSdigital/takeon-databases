import psycopg2
import os
import random

# Variables
user = os.getenv('AZ_COLLECTION_DB_USER')
sslmode = "require"
password = os.getenv('AZ_COLLECTION_DB_PASSWORD')
host = os.getenv('AZ_COLLECTION_DB_SERVER')
dbname = os.getenv('AZ_COLLECTION_DB_NAME')
formula = ' != " "'
test_username = 'takeonadmin'
counterVar = 0

# Construct connection string
def create_connection():
    conn_string = "host={0} user={1} dbname={2} password={3} sslmode={4}".format(host, user, dbname, password, sslmode)
    conn = psycopg2.connect(conn_string)
    print("Connection established")
    return conn

def create_cursor(connection):
    cursor = connection.cursor()
    return cursor

def close_conections(cursor, connection):
    connection.commit()
    cursor.close()
    connection.close()

connection = create_connection()
cursor = create_cursor(connection)

# Drop tables to start
cursor.execute("DROP TABLE IF EXISTS holderTable")
cursor.execute("DROP TABLE IF EXISTS insertTable")

create_query = """CREATE TABLE holderTable (
ID INT GENERATED ALWAYS AS IDENTITY,
Reference char(11),
Period char(6),
Survey char(3),
FormID BigInt,
QuestionCode char(4),
Response varchar(256),
Instance int
)
"""

cursor.execute(create_query)
print('holderTable created')

create_query = """CREATE TABLE insertTable
(Reference char(11),
Period	char(6),
Survey char(3),
FormID BigInt,
QuestionCode char(4),
Response varchar(256),
Severity char(1),
Instance int)"""

cursor.execute(create_query)
print('insertTable created')

insert_query = """Insert into holderTable(Reference, Period, Survey, FormID, Response, QuestionCode, Instance)
select Reference, Period, Survey, JFor, Response, QuestionCode, Instance from
(select joined.Reference as JRef, joined.Period as JPer, joined.Survey as JSur, joined.FormID as JFor from
(select
cont.Reference,
cont.Period,
cont.Survey,
cont.FormID from dev01.Contributor cont
INNER JOIN dev01.Form
on dev01.Form.FormID = cont.FormID and dev01.Form.Survey = cont.Survey)
as joined )
as contribs
INNER JOIN dev01.Response on
contribs.JRef = dev01.Response.Reference
and contribs.JPer = dev01.Response.Period
and contribs.JSur = dev01.Response.Survey;"""

cursor.execute(insert_query)

cursor.execute("SELECT count(*) from holderTable")
# Returns tuple
holderCount = cursor.fetchone()
holderCount = holderCount[0]
print("Holder count = " + str(holderCount))

while counterVar < holderCount:
    severity = random.choice(['E','W'])
    query = (
    'INSERT INTO insertTable (Reference, Period, Survey, FormID, QuestionCode, Response, Severity, Instance)'
    ' SELECT Reference, Period, Survey, FormID, QuestionCode, Response, %s, Instance'
    ' FROM holderTable'
    ' WHERE ID = %s and Response IS NOT NULL ')
    data = (severity, counterVar)
    cursor.execute(query, data)
    counterVar += 1

cursor.execute("SELECT COUNT(*) from insertTable")
insertTableCount = cursor.fetchone()
insertTableCount = insertTableCount[0]
print("Inserted {} random errors into insertTable".format(insertTableCount))

validationQuery = (
'INSERT INTO dev01.ValidationOutput (Reference, Period, Survey, Instance, ValidationID, PrimaryValue, Formula, CreatedBy, CreatedDate)'
' SELECT it.Reference, it.Period, it.Survey, it.Instance, vf.validationID,'
' it.Response, concat(it.Response, %s), %s, NOW() '
' FROM insertTable it'
' INNER JOIN dev01.ValidationForm vf'
' on vf.FormID = it.FormID'
' and vf.QuestionCode = it.QuestionCode;'.format(formula, user))

data = (formula, test_username)
cursor.execute(validationQuery, data)
cursor.execute("SELECT COUNT(*) from dev01.ValidationOutput")
validationTableCount = cursor.fetchone()
validationTableCount = validationTableCount[0]
print("Inserted {} rows into Validation Output Table".format(validationTableCount))

# Cleanup
cursor.execute("DROP TABLE holderTable")
cursor.execute("DROP TABLE insertTable")
close_conections(cursor, connection)
