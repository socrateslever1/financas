-- Estrutura inicial verificada do SQLite contido no APK 7.2.3.
-- 28 tabelas, 360 colunas. Mantém nomes e chaves primárias.

CREATE TABLE IF NOT EXISTS "cartoes_credito" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "nome" TEXT,
  "cor" NUMERIC,
  "img_id" NUMERIC,
  "num_cartao" TEXT,
  "limite" NUMERIC,
  "id_conta" TEXT,
  "dia_venc" NUMERIC,
  "dia_fecha" NUMERIC,
  "data_exclusao" DATETIME,
  "conta_vinculada" TEXT,
  "padrao" TEXT,
  "tipo" TEXT,
  "fechamento_dias_uteis" TEXT,
  "text_alt" TEXT,
  "sequence" NUMERIC,
  "dias_fechamento" NUMERIC
);

CREATE TABLE IF NOT EXISTS "cartoes_credito_mes" (
  "id_cartao" TEXT,
  "mes" NUMERIC,
  "ano" NUMERIC,
  "limite" NUMERIC,
  "id_conta" TEXT,
  "dia_venc" NUMERIC,
  "dia_fecha" NUMERIC,
  "fatura_paga" TEXT,
  "conta_vinculada" TEXT,
  "attach_id" TEXT,
  "attach_path" TEXT,
  "attach_size" NUMBER,
  PRIMARY KEY ("id_cartao", "mes", "ano")
);

CREATE TABLE IF NOT EXISTS "contas" (
  "id" TEXT PRIMARY KEY,
  "descricao" TEXT,
  "exibir_resumo" TEXT,
  "data_cadastro" DATETIME,
  "data_exclusao" DATETIME,
  "somar_total" TEXT,
  "padrao" TEXT,
  "id_categoria" TEXT,
  "cheque_especial" REAL,
  "fav" NUMERIC,
  "exibir_saldo" TEXT,
  "image_id" NUMERIC,
  "padrao_importacao" TEXT,
  "dados_adicionais" TEXT,
  "sequence" NUMERIC,
  "id_profile" TEXT
);

CREATE TABLE IF NOT EXISTS "contas_cat" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "descricao" TEXT,
  "cor" NUMERIC,
  "padrao" TEXT,
  "rate" NUMERIC,
  "not_dash" TEXT,
  "not_resume" TEXT,
  "not_balance" TEXT,
  "icon_id" NUMERIC
);

CREATE TABLE IF NOT EXISTS "contas_saldo" (
  "id_conta" TEXT,
  "mes" NUMERIC,
  "ano" NUMERIC,
  "si" REAL,
  "cheque_especial" REAL,
  "obs" TEXT,
  "si_custom" NUMERIC,
  PRIMARY KEY ("id_conta", "mes", "ano")
);

CREATE TABLE IF NOT EXISTS "despesas" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "descricao" TEXT,
  "data_evento" DATETIME,
  "id_event" TEXT,
  "id_calendario" TEXT,
  "num_parcela" NUMERIC,
  "num_parcelas" NUMERIC,
  "id_categoria" TEXT,
  "id_origem" TEXT,
  "id_conta" TEXT,
  "data_cadastro" DATETIME,
  "obs" TEXT,
  "status" TEXT,
  "valor" DOUBLE,
  "recorrencia" TEXT,
  "data" DATETIME,
  "latitude" TEXT,
  "longitude" TEXT,
  "sms" NUMERIC,
  "juros" NUMERIC,
  "id_subcategoria" TEXT,
  "id_cartao_credito" TEXT,
  "id_despesa_estornada" TEXT,
  "data_update" DATETIME,
  "data_exclusao" DATETIME,
  "considerar_estatistica" TEXT,
  "contabilizar" TEXT,
  "ef_auto" TEXT,
  "parc_inicial" NUMERIC,
  "somar_total" TEXT,
  "dados_fatura" TEXT,
  "attach_id" TEXT,
  "attach_path" TEXT,
  "automatica" TEXT,
  "intervalo" NUMERIC,
  "id_orig_parcial" TEXT,
  "dt_orig_parcial" DATETIME,
  "economia_mensal" TEXT,
  "ef_inicio_dia" TEXT,
  "data_efetivacao" DATETIME,
  "local" TEXT,
  "place_id" TEXT,
  "cupom_url" TEXT,
  "adiantamento_fatura" TEXT,
  "limite_cartao" TEXT,
  "attach_size" NUMBER
);

CREATE TABLE IF NOT EXISTS "despesas_cat" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "nome" TEXT,
  "cor" NUMERIC,
  "rate" NUMERIC,
  "orcamento" TEXT,
  "not_dash" TEXT,
  "icon_id" NUMERIC,
  "not_resume" TEXT,
  "not_balance" TEXT,
  "data_exclusao" DATETIME
);

CREATE TABLE IF NOT EXISTS "despesas_cat_valor" (
  "id" TEXT PRIMARY KEY,
  "id_despesa" TEXT,
  "id_categoria" TEXT,
  "id_subcategoria" TEXT,
  "valor" REAL,
  "obs" TEXT,
  "excluido" TEXT,
  "data" DATETIME
);

CREATE TABLE IF NOT EXISTS "despesas_fixas" (
  "id" TEXT PRIMARY KEY,
  "id_despesa" TEXT,
  "data" DATETIME,
  "valor" REAL,
  "status" TEXT,
  "obs" TEXT,
  "id_conta" TEXT,
  "id_cartao_credito" TEXT,
  "contabilizar" TEXT,
  "excluido_mes" TEXT,
  "juros" NUMERIC,
  "dia_venc" NUMERIC,
  "attach_id" TEXT,
  "attach_path" TEXT,
  "data_efetivacao" DATETIME,
  "attach_size" NUMBER
);

CREATE TABLE IF NOT EXISTS "despesas_subcat" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "id_categoria" TEXT,
  "nome" TEXT,
  "cor" NUMERIC,
  "icon_id" NUMERIC,
  "rate" NUMERIC,
  "orcamento" TEXT,
  "data_exclusao" DATETIME
);

CREATE TABLE IF NOT EXISTS "filtros" (
  "id" TEXT PRIMARY KEY,
  "descricao" TEXT,
  "data_inicio" DATETIME,
  "data_fim" DATETIME,
  "recorrencia" TEXT,
  "tipo_data" TEXT,
  "tipo" INTEGER,
  "obs" TEXT,
  "hashtag" TEXT,
  "temp" TEXT,
  "order_index" TEXT,
  "status" TEXT,
  "id_profile" TEXT,
  "apenas_debito" TEXT,
  "resumo" TEXT,
  "descricao_transacao" TEXT
);

CREATE TABLE IF NOT EXISTS "filtros_cartoes" (
  "id_filtro" TEXT,
  "id_cartao" TEXT
);

CREATE TABLE IF NOT EXISTS "filtros_categorias" (
  "id_filtro" TEXT,
  "id_categoria" TEXT,
  "id_subcategoria" TEXT
);

CREATE TABLE IF NOT EXISTS "filtros_contas" (
  "id_filtro" TEXT,
  "id_conta" TEXT,
  "tipo_conta" TEXT
);

CREATE TABLE IF NOT EXISTS "login" (
  "id" TEXT PRIMARY KEY,
  "pwd" TEXT
);

CREATE TABLE IF NOT EXISTS "objetivos" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "descricao" TEXT,
  "meta" REAL,
  "data_cadastro" DATETIME,
  "expec" DATETIME,
  "data_realizado" DATETIME,
  "saldo_inicial" REAL,
  "motivacao" TEXT,
  "realizado" TEXT,
  "icon_id" NUMERIC,
  "color" NUMERIC
);

CREATE TABLE IF NOT EXISTS "objetivos_dep" (
  "id" TEXT PRIMARY KEY,
  "id_objetivo" TEXT,
  "valor" REAL,
  "data" DATETIME,
  "mensal" TEXT,
  "obs" TEXT
);

CREATE TABLE IF NOT EXISTS "orcamentos" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "id_categoria" TEXT,
  "id_subcategoria" TEXT,
  "meta" REAL,
  "tipo" TEXT,
  "exibir_resumo" TEXT,
  "notify_over" TEXT,
  "data_criacao" DATETIME,
  "somar_sub" TEXT,
  "dias" NUMERIC,
  "perc_alerta" NUMERIC,
  "data_exclusao" DATETIME,
  "nao_somadas" TEXT
);

CREATE TABLE IF NOT EXISTS "orcamentos_mensal" (
  "id_orcamento" TEXT,
  "meta" REAL,
  "efet" REAL,
  "pend" REAL,
  "data" DATETIME
);

CREATE TABLE IF NOT EXISTS "preferencias" (
  "naoListarPagos" TEXT,
  "obsAutomatica" TEXT,
  "idCategoriaInicial" NUMERIC,
  "flagDate" TEXT,
  "horarioAlarme" NUMERIC,
  "ativarAlarmeCalendario" TEXT,
  "marcarEventosExternos" TEXT,
  "idCalendario" TEXT,
  "ativarIntegracaoCalendario" TEXT,
  "orderField" NUMERIC,
  "pendenteSempre" TEXT,
  "flag" TEXT,
  "enableNotification" TEXT,
  "vibrarTeclas" TEXT,
  "idCategoriaFiltro" NUMERIC,
  "considereTodos" TEXT,
  "considereDataCadastro" TEXT,
  "marcarVencidos" TEXT,
  "dataFim" DATETIME,
  "dataInicio" DATETIME,
  "apenasMesAtual" TEXT,
  "iniciarComFinanca" TEXT,
  "dataCadastroManual" TEXT,
  "tipoGasto" TEXT,
  "nomeUsuario" TEXT,
  "avisarGastos" TEXT,
  "id" INTEGER PRIMARY KEY,
  "indexAntecedenciaAvisos" NUMERIC,
  "lastCountId" NUMERIC,
  "answer" TEXT,
  "question" TEXT,
  "user" TEXT,
  "update_id" NUMERIC,
  "prefs" TEXT
);

CREATE TABLE IF NOT EXISTS "profiles" (
  "id" TEXT PRIMARY KEY,
  "name" TEXT,
  "current" TEXT,
  "color" NUMERIC,
  "icon" NUMERIC,
  "archived" TEXT
);

CREATE TABLE IF NOT EXISTS "receitas" (
  "id" TEXT PRIMARY KEY,
  "id_origem" TEXT,
  "id_profile" TEXT,
  "id_conta" TEXT,
  "data" DATETIME,
  "valor" REAL,
  "descricao" TEXT,
  "somar_total" TEXT,
  "considerar_estatistica" TEXT,
  "data_exclusao" DATETIME,
  "data_cadastro" DATETIME,
  "id_categoria" TEXT,
  "id_subcategoria" TEXT,
  "data_update" DATETIME,
  "obs" TEXT,
  "efetivado" TEXT,
  "ef_auto" TEXT,
  "intervalo" NUMERIC,
  "num_parcela" NUMERIC,
  "num_parcelas" NUMERIC,
  "recorrencia" TEXT,
  "attach_id" TEXT,
  "attach_path" TEXT,
  "id_orig_parcial" TEXT,
  "dt_orig_parcial" DATETIME,
  "economia_mensal" TEXT,
  "ef_inicio_dia" TEXT,
  "local" TEXT,
  "data_efetivacao" DATETIME,
  "attach_size" NUMBER
);

CREATE TABLE IF NOT EXISTS "receitas_cat" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "descricao" TEXT,
  "cor" NUMERIC,
  "rate" NUMERIC,
  "orcamento" TEXT,
  "not_dash" TEXT,
  "icon_id" NUMERIC,
  "not_resume" TEXT,
  "data_exclusao" DATETIME
);

CREATE TABLE IF NOT EXISTS "receitas_fixas" (
  "id" INTEGER PRIMARY KEY,
  "id_receita" TEXT,
  "data" DATETIME,
  "excluido_mes" TEXT,
  "valor" REAL,
  "obs" TEXT,
  "efetivado" TEXT,
  "id_conta" TEXT,
  "dia_venc" NUMERIC,
  "attach_id" TEXT,
  "attach_path" TEXT,
  "data_efetivacao" DATETIME,
  "attach_size" NUMBER
);

CREATE TABLE IF NOT EXISTS "receitas_subcat" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "id_categoria" TEXT,
  "nome" TEXT,
  "cor" NUMERIC,
  "icon_id" NUMERIC,
  "rate" NUMERIC,
  "orcamento" TEXT,
  "data_exclusao" DATETIME
);

CREATE TABLE IF NOT EXISTS "sugestoes_ignore" (
  "desc" TEXT,
  "type" TEXT,
  "id_profile" TEXT
);

CREATE TABLE IF NOT EXISTS "transferencias" (
  "id" TEXT PRIMARY KEY,
  "id_profile" TEXT,
  "id_origem" TEXT,
  "id_conta_origem" TEXT,
  "id_conta_destino" TEXT,
  "data" DATETIME,
  "valor" REAL,
  "contabilizada" TEXT,
  "descricao" TEXT,
  "obs" TEXT,
  "data_update" DATETIME,
  "recorrencia" TEXT,
  "id_desp_encargos" TEXT,
  "ef_auto" TEXT,
  "intervalo" NUMERIC,
  "num_parcela" NUMERIC,
  "num_parcelas" NUMERIC,
  "data_exclusao" DATETIME,
  "attach_id" TEXT,
  "attach_path" TEXT,
  "ef_inicio_dia" TEXT,
  "attach_size" NUMBER,
  "cotacao" NUMBER
);

CREATE TABLE IF NOT EXISTS "transferencias_fixas" (
  "id" TEXT PRIMARY KEY,
  "id_transferencia" TEXT,
  "id_conta_origem" TEXT,
  "id_conta_destino" TEXT,
  "data" DATETIME,
  "excluido_mes" TEXT,
  "valor" REAL,
  "dia_venc" INTEGER,
  "contabilizada" TEXT,
  "id_desp_encargos" TEXT,
  "obs" TEXT,
  "attach_id" TEXT,
  "attach_path" TEXT,
  "attach_size" NUMBER,
  "cotacao" NUMBER
);

CREATE INDEX IF NOT EXISTS "idx_contas_id_profile" ON "contas" ("id_profile");

CREATE INDEX IF NOT EXISTS "idx_receitas_id_profile" ON "receitas" ("id_profile");

CREATE INDEX IF NOT EXISTS "idx_receitas_id_conta" ON "receitas" ("id_conta");

CREATE INDEX IF NOT EXISTS "idx_receitas_id_categoria" ON "receitas" ("id_categoria");

CREATE INDEX IF NOT EXISTS "idx_despesas_id_profile" ON "despesas" ("id_profile");

CREATE INDEX IF NOT EXISTS "idx_despesas_id_conta" ON "despesas" ("id_conta");

CREATE INDEX IF NOT EXISTS "idx_despesas_id_categoria" ON "despesas" ("id_categoria");

CREATE INDEX IF NOT EXISTS "idx_despesas_id_cartao_credito" ON "despesas" ("id_cartao_credito");

CREATE INDEX IF NOT EXISTS "idx_transferencias_id_profile" ON "transferencias" ("id_profile");

CREATE INDEX IF NOT EXISTS "idx_transferencias_id_conta_origem" ON "transferencias" ("id_conta_origem");

CREATE INDEX IF NOT EXISTS "idx_transferencias_id_conta_destino" ON "transferencias" ("id_conta_destino");

CREATE INDEX IF NOT EXISTS "idx_cartoes_credito_id_profile" ON "cartoes_credito" ("id_profile");

CREATE INDEX IF NOT EXISTS "idx_objetivos_id_profile" ON "objetivos" ("id_profile");

CREATE INDEX IF NOT EXISTS "idx_orcamentos_id_profile" ON "orcamentos" ("id_profile");

CREATE TABLE IF NOT EXISTS "web_meta" (id TEXT PRIMARY KEY,version INTEGER NOT NULL DEFAULT 0,updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);

INSERT OR IGNORE INTO web_meta (id,version) VALUES ('main',0);
