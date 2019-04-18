from sqlalchemy import create_engine, MetaData
from sqlalchemy.engine import reflection
import random
import datetime
engine = create_engine("postgresql://postgres:password@localhost:5432/collectiondev")

meta = MetaData()
insp = reflection.Inspector.from_engine(engine)

# Get all the table data from the built database
# Build a series of classes that have the column metadata
# as attributes
class Generic:
    def __init__(self):
        self.metadata = reflection.Inspector.from_engine(engine)
        self.table_names = self.metadata.get_table_names()
        self.meta_dict = {table: None for table in self.table_names}
        self.class_dict = {table: None for table in self.table_names}
    def add_metadata_to_dict(self):
        for table in self.table_names:
            self.meta_dict[table] = self.metadata.get_columns(table)
    def create_class(self):
        self.add_metadata_to_dict()
        for table in self.meta_dict.keys():
            self.class_dict[table] = type(table, (), {table: self.meta_dict[table]})
        return self.class_dict

class AddData:
    def __init__(self):
        # Here we have a dictionary of classes, each class is indexed by
        # it's table name.
        self.table_classes = Generic().create_class()
        # Create some base data to build from
        self.years = ["{}".format(i) for i in range(1990, 2020)]
        self.months = ["0{}".format(i) if i < 10 else "{}".format(i) for i in range(1, 13)]
        self.surveys = ["066", "067", "077", "076"]
        # Construct come contributor keys from the base data
        self.contributor_key = (self.years[random.randint(0, len(self.years)-1)] 
                                + self.months[random.randint(0, len(self.months)-1)] 
                                + self.surveys[random.randint(0, len(self.surveys)-1)] for i in range(10000))
        # We will be using this dictionary to keep track of all
        # our contributors and their attributes
        self.contributor_dict = {i: {} for i in self.contributor_key}
    def create_key(self):
        '''
        We created a since unique key to keep track of our contributors
        but we still need to have ref/period/survey individually. These
        will be our first attributes.
        '''
        for i in self.contributor_dict.keys():
            self.contributor_dict[i]["reference"] = i[0:4]
            self.contributor_dict[i]["period"] = i[4:6]
            self.contributor_dict[i]["survey"] = i[6:9]
            self.contributor_dict[i]["responses"] = {}
            self.contributor_dict[i]["createdBy"] = "fisdba"
            self.contributor_dict[i]["createdDate"] = datetime.datetime.now()

x = AddData()
x.create_key()
print(x.contributor_dict["199603076"])


