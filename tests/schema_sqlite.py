import sqlite3,pathlib,unittest
ROOT=pathlib.Path(__file__).resolve().parent.parent
class PortedSchema(unittest.TestCase):
 def test_generated_schema_and_runtime(self):
  c=sqlite3.connect(":memory:")
  for name in ["0002_original_schema.sql","0003_runtime_columns.sql"]:
   c.executescript((ROOT/"database/migrations"/name).read_text())
  tables=[r[0] for r in c.execute("select name from sqlite_master where type='table' and name not like 'sqlite_%' and name!='web_meta'")]
  self.assertEqual(len(tables),28)
  self.assertEqual(sum(len(list(c.execute(f'pragma table_info("{t}")'))) for t in tables),453)
  c.execute("INSERT INTO profiles (id,name) VALUES ('demo','Demo')")
  c.execute("INSERT INTO contas (id,descricao,currency) VALUES ('1','Conta','BRL')")
  self.assertEqual(c.execute("SELECT currency FROM contas WHERE id=?",("1",)).fetchone()[0],"BRL")
  c.execute("INSERT INTO cartoes_credito (id,nome) VALUES ('a','Cartão')")
  c.execute("INSERT INTO cartoes_credito_mes (id_cartao,mes,ano,limite) VALUES ('a',10,2026,2000)")
  with self.assertRaises(sqlite3.IntegrityError):
   c.execute("INSERT INTO cartoes_credito_mes (id_cartao,mes,ano) VALUES ('a',10,2026)")
if __name__=="__main__":unittest.main()
