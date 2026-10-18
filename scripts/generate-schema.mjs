import {runtimeExtra} from "../database/runtime-columns.js";
import {readSchema} from "../database/schema-map.js";
import {writeFileSync,mkdirSync} from "node:fs";
const tables=readSchema(), ddl=[];
for(const [name,columns] of Object.entries(tables)){
 const pk=columns.filter(c=>c.primary).map(c=>c.name);
 const definitions=columns.map(c=>'"'+c.name+'" '+c.type+(pk.length===1&&c.primary?" PRIMARY KEY":"")+(name==="despesas_cat_valor"&&["id_despesa","id_categoria","id_subcategoria","valor","data"].includes(c.name)?" NOT NULL":"")+(name==="despesas_cat_valor"&&c.name==="excluido"?" DEFAULT 'N'":""));
 if(pk.length>1)definitions.push("PRIMARY KEY ("+pk.map(c=>'"'+c+'"').join(",")+")");
 ddl.push('CREATE TABLE IF NOT EXISTS "'+name+'" (\n  '+definitions.join(",\n  ")+'\n);');
}
for(const [table,fields] of Object.entries({contas:["id_profile"],receitas:["id_profile","id_conta","id_categoria"],despesas:["id_profile","id_conta","id_categoria","id_cartao_credito"],transferencias:["id_profile","id_conta_origem","id_conta_destino"],cartoes_credito:["id_profile"],objetivos:["id_profile"],orcamentos:["id_profile"]})){
 for(const field of fields)ddl.push('CREATE INDEX IF NOT EXISTS "idx_'+table+'_'+field+'" ON "'+table+'" ("'+field+'");');
}
ddl.push('CREATE TABLE IF NOT EXISTS "web_meta" (id TEXT PRIMARY KEY,version INTEGER NOT NULL DEFAULT 0,updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);');
ddl.push("INSERT OR IGNORE INTO web_meta (id,version) VALUES ('main',0);");
mkdirSync("database/migrations",{recursive:true});
writeFileSync("database/migrations/0002_original_schema.sql","-- Esquema portado do SQLite de Minhas Finanças 7.2.3.\n-- Os 28 nomes de tabelas e suas 360 colunas são preservados.\n\n"+ddl.join("\n\n")+"\n");
const runtime=runtimeExtra();const migration=[];
for(const [table,cols] of Object.entries(runtime))for(const col of cols)migration.push('ALTER TABLE "'+table+'" ADD COLUMN "'+col.name+'" '+col.type+';');
writeFileSync("database/migrations/0003_runtime_columns.sql","-- Campos observados nos scripts SQL do APK (não constam no SQLite inicial).\n-- Tipos inferidos, a verificar com os comandos e a execução real.\n"+migration.join("\n")+"\n");
console.log("Geradas",Object.keys(tables).length,"tabelas originais,",(Object.values(tables).reduce((s,x)=>s+x.length,0)),"colunas.");
