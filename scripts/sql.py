#from sqlalchemy import create_engine, MetaData,Table, Column, Integer, String, ForeignKey, select
#
#engine = create_engine('sqlite:///foo.db', echo=True)
#metadata = MetaData(engine)
##user_table = ...
#user = Table('user', metadata,
#        Column('id', Integer, primary_key=True),
#        Column('name', String(50)),
#        Column('fullname', String(100))
#        )
#
#address = Table('address', metadata,
#        Column('id', Integer, primary_key=True),
#        Column('user_id', None, ForeignKey('user.id')),
#        Column('email', String(128), nullable=False)
#        )
#
#metadata.create_all()
#conn = engine.connect()
#
#print('user' in metadata.tables)
#print([c.name for c in user.columns])
#print('address' in metadata.tables)
#
#
##insert
#ins = user.insert()
#print(ins)
#ins = ins.values(name='adam', fullname='Adam Gu')
#print(ins)
#
#result = conn.execute(ins)
#
## insert multiple
#ins = user.insert()
#conn.execute(ins, name='david', fullname='David Deng')
#conn.execute(ins, name='gartner', fullname='Gartner Gold')
#conn.execute(ins, id=10, name='starlin', fullname='Starlin F')
#
#conn.execute(address.insert(), [
#{ 'user_id': 1, 'email': 'sprinfall@gmail.com' },
#{ 'user_id': 1, 'email': 'sprinfall@hotmail.com' },
#])



from sqlalchemy import create_engine, MetaData,Table, Column, Integer, String, ForeignKey, select

engine = create_engine('sqlite:///foo.db', echo=True)
metadata = MetaData(engine)
#reflect
#help(metadata.reflect()) Load(reflect) all available table definitions from the database
metadata.reflect()
#read(reflect) table named 'user' from database, NOTE that param 'only' MUST be a dict for it to not be treated as{'u', 's', 'e', 'r'}
#metadata.reflect(only={'user'}) 

user = metadata.tables['user'] # alread loaded this table structure by reflecting
address = metadata.tables['address']
print(user.c)

metadata.create_all() # skip if existed, so skippable here
conn = engine.connect()

#select - generate sql select cmd
#SELECT user.name, user.fullname FROM user
query = select([user.c.name, user.c.fullname]) 
print(query)

#user.id field is not printed
#[('adam', 'Adam Gu'), ('david', 'David Deng'), ('gartner', 'Gartner Gold'), ('starlin', 'Starlin F')]
conn.execute(query).fetchall()
conn.execute(select([address])).fetchall()

# select from 2 tables user, address
conn.execute(select([user.c.name, address.c.user_id, address.c.email]).where(user.c.id==address.c.user_id)).fetchall()

#update all the fullname field with user.c.name   then read user and check
#[(1, 'adam', 'adam'), (2, 'david', 'david'), (3, 'gartner', 'gartner'), (10, 'starlin', 'starlin')]
conn.execute(user.update().values(fullname=user.c.name))
conn.execute(select([user])).fetchall()
