import test from "node:test";
import assert from "node:assert/strict";
import{readSchema}from "../database/schema-map.js";
test("banco do APK contém 28 tabelas e 360 colunas",()=>{const s=readSchema();assert.equal(Object.keys(s).length,28);assert.equal(Object.values(s).reduce((a,b)=>a+b.length,0),360)});
test("nomes de colunas, parcelas, faturas, recorrências preservados",()=>{const s=readSchema();for(const [table,names] of Object.entries({contas:["descricao","somar_total"],contas_saldo:["si","mes","ano"],despesas:["num_parcela","num_parcelas","id_cartao_credito","recorrencia"],despesas_fixas:["id_despesa","data"],receitas:["efetivado","recorrencia"],transferencias:["id_conta_origem","id_conta_destino"],cartoes_credito_mes:["fatura_paga","dia_fecha","dia_venc"]}))for(const col of names)assert.ok(s[table].some(x=>x.name===col),table+"."+col)});
