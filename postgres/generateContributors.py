"""Generate an arbitrary number of contributors and insert them into a PostgreSQL database on Azure
"""

import psycopg2
import random
import datetime
import os

class Contributor():
    def __init__(self,Reference="", Period="",Survey=""):
        self.Reference = Reference
        period_list = ['201712', '201509', '201706', '201901', '201812', '201806', '201512', '201809', '201703',
                       '201803', '201103', '201106', '201109', '201112']
        self.Period = random.choice(period_list)
        survey_list = [['1','066'], ['2','073'], ['3','076'], ['4','074']]
        formInfo = random.choice(survey_list)
        self.Survey = formInfo[1]
        self.FormID = formInfo[0]

    def randomise(self):
        # self.FormID = random.randint(1, 4)
        self.Status = random.choice(['No Response', 'Validation Failed', 'Saved not Validated', 'Overridden', ' Dead'])
        self.ReceiptDate = None

        if random.randint(0, 10) == 1:
            self.LockedBy = 'Alan'
            self.LockedDate = datetime.datetime.now()
        else:
            self.LockedBy = ''
            self.LockedDate = None

        self.FormType = random.choice(['0001', '0002', '0003', '0004'])
        self.Checkletter = random.choice(['A', 'E', 'I', 'X'])
        self.FrozenSicOutdated = '56423'
        self.RuSicOutdated = '56424'
        self.FrozenSic = '56426'
        self.RuSic = '56424'
        self.FrozenEmployees = random.randint(0, 500000)
        self.Employees = random.randint(0, 500000)
        self.FrozenEmployment = random.randint(0, 500000)
        self.Employment = random.randint(0, 500000)
        self.FrozenFteEmployment = round(random.uniform(0, 500000), 2)
        self.FteEmployment = round(random.uniform(0, 500000), 2)
        self.FrozenTurnover = random.randint(0, 1000000)
        self.Turnover = random.randint(0,1000000)
        self.EnterpriseReference = 9900000000 + random.randint(1, 1000000)
        self.WowEnterpriseReference = random.randint(0, 999999999)
        self.CellNumber = random.randint(0, 1000)
        self.Currency = random.choice(['E', 'S'])
        self.VatReference = '123456789012'
        self.PayeReference = '3210987654321'
        self.CompanyRegistrationNumber = '123456'
        self.NumberLiveLocalUnits = random.randint(1, 10000)
        self.NumberLiveVat = random.randint(1, 10000)
        self.NumberLivePaye = random.randint(1, 10000)
        self.LegalStatus = random.randint(1, 9)
        self.ReportingUnitMarker = 'A'
        self.Region = 'AA'
        self.BirthDate = ''
        self.EnterpriseName = 'An enterprise name'
        self.ReferenceName = 'A reference name'
        self.ReferenceAddress = 'A random reference address'
        self.ReferencePostcode = random.choice(['AA9A 9AA', 'A9A 9AA', 'A99 9AA', 'A9 9AA', 'AA9 9AA', 'AA99 9AA'])
        self.TradingStyle = 'A random trading style'
        self.Contact = 'Mr contact person'
        self.Telephone = '01234 567 890'
        self.Fax = '+0044 1234 567 891'
        self.SelectionType = 'G'
        self.InclusionExclusion = 'X'
        self.CreatedBy = 'Frank'
        self.CreatedDate = datetime.datetime.now()

    def getAttributeValues(self):
        attributes = []
        attributes.append(self.Reference)
        attributes.append(self.Period)
        attributes.append(self.Survey)
        attributes.append(self.FormID)
        attributes.append(self.Status)
        attributes.append(self.ReceiptDate)
        attributes.append(self.LockedBy)
        attributes.append(self.LockedDate)
        attributes.append(self.FormType)
        attributes.append(self.Checkletter)
        attributes.append(self.FrozenSicOutdated)
        attributes.append(self.RuSicOutdated)
        attributes.append(self.FrozenSic)
        attributes.append(self.RuSic)
        attributes.append(self.FrozenEmployees)
        attributes.append(self.Employees)
        attributes.append(self.FrozenEmployment)
        attributes.append(self.Employment)
        attributes.append(self.FrozenFteEmployment)
        attributes.append(self.FteEmployment)
        attributes.append(self.FrozenTurnover)
        attributes.append(self.Turnover)
        attributes.append(self.EnterpriseReference)
        attributes.append(self.WowEnterpriseReference)
        attributes.append(self.CellNumber)
        attributes.append(self.Currency)
        attributes.append(self.VatReference)
        attributes.append(self.PayeReference)
        attributes.append(self.CompanyRegistrationNumber)
        attributes.append(self.NumberLiveLocalUnits)
        attributes.append(self.NumberLiveVat)
        attributes.append(self.NumberLivePaye)
        attributes.append(self.LegalStatus)
        attributes.append(self.ReportingUnitMarker)
        attributes.append(self.Region)
        attributes.append(self.BirthDate)
        attributes.append(self.EnterpriseName)
        attributes.append(self.ReferenceName)
        attributes.append(self.ReferenceAddress)
        attributes.append(self.ReferencePostcode)
        attributes.append(self.TradingStyle)
        attributes.append(self.Contact)
        attributes.append(self.Telephone)
        attributes.append(self.Fax)
        attributes.append(self.SelectionType)
        attributes.append(self.InclusionExclusion)
        attributes.append(self.CreatedBy)
        attributes.append(self.CreatedDate)

        return attributes


class SimpleMsSqlConnection():
    def __init__(self, Database = ""):
        # self.Driver = '{ODBC Driver 17 for SQL Server}'
        # self.Driver = '{PostgreSQL Unicode}'
        self.user = "takeonadmin@takeon"
        self.sslmode = "require"
        self.password = os.getenv('AZ_COLLECTION_DB_PASSWORD')
        self.host = os.getenv('AZ_COLLECTION_DB_SERVER')
        self.ConnectionString = "host={0} user={1} dbname={2} password={3} sslmode={4}".format(self.host, self.user,
        Database, self.password, self.sslmode)


    def connect(self):
        self.connection = psycopg2.connect(self.ConnectionString)
        print ("Connection Established")
        self.cursor = self.connection.cursor()
        #self.cursor.fast_executemany = True

    def runSQL(self, command = "", parameters = ""):
        try:
            self.connect()
            self.cursor.executemany(command,parameters)
            self.connection.commit()
        except Exception as e:
            print(str(e))
        finally:
            self.disconnect()

    def disconnect(self):
        self.cursor.close()  # Closing connections
        self.connection.close()


def generateUniqueReferenceUsingOffset(baseReference='00000000000', increment=1):
    return baseReference[0:len(baseReference) - len(str(increment))] + str(increment)


def generateInsertSqlParameters(rowsToInsert=1, startReference='', survey = '', period = ''):
    sqlParameters = []
    for i in range(0,rowsToInsert):
        reference = generateUniqueReferenceUsingOffset(baseReference=startReference,increment=i)
        sqlParameters.append(generateContributorAttributes(reference, period=period))
    return sqlParameters

# Create a random contributor with a fixed reference, survey & period (passed in)
# Return a list of the contributor attributes
def generateContributorAttributes(reference='49900000000', survey='1', period='190000'):
    contributor = Contributor(Reference=reference, Survey=survey, Period=period)
    contributor.randomise()
    return contributor.getAttributeValues()

def insertContributorsToDb(sqlParameters = ''):
    query = "Insert Into dev01.Contributor (Reference,Period,Survey,FormID,Status,ReceiptDate,LockedBy," \
            "LockedDate,FormType,Checkletter,FrozenSicOutdated,RuSicOutdated,FrozenSic,RuSic,FrozenEmployees," \
            "Employees,FrozenEmployment,Employment,FrozenFteEmployment,FteEmployment,FrozenTurnover,Turnover," \
            "EnterpriseReference,WowEnterpriseReference,CellNumber,Currency,VatReference,PayeReference," \
            "CompanyRegistrationNumber,NumberLiveLocalUnits,NumberLiveVat,NumberLivePaye,LegalStatus," \
            "ReportingUnitMarker,Region,BirthDate,EnterpriseName,ReferenceName,ReferenceAddress,ReferencePostcode," \
            "TradingStyle,Contact,Telephone,Fax,SelectionType,InclusionExclusion,CreatedBy,CreatedDate) " \
            "Values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    connection = SimpleMsSqlConnection(Database=os.getenv('AZ_COLLECTION_DB_NAME'))
    connection.runSQL(query, sqlParameters)

def main():
    sqlParameters = generateInsertSqlParameters(rowsToInsert=100, startReference='49900000001', survey='066',
                                                period='201512')
    # creationTime = round(timeit.default_timer() - startTime, 2)
    insertContributorsToDb(sqlParameters)

if __name__ == "__main__":
    main()
