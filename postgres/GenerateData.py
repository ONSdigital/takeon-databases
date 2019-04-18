from sqlalchemy import create_engine, MetaData
from sqlalchemy.engine import reflection
engine = create_engine("postgresql://postgres:password@localhost:5432/collectiondev")

meta = MetaData()
insp = reflection.Inspector.from_engine(engine)
print(insp.get_table_names())

# Get all the table data from the built database
class Generic:
    def __init__(self):
        self.metadata = reflection.Inspector.from_engine(engine)
        self.table_names = self.metadata.get_table_names()
        self.output_dict = {table: None for table in self.table_names}
    def get_columns(self):
        print(self.metadata.get_columns(self.table_names[0]))
    def build_table_classes(self):
        for table in self.table_names:
            
