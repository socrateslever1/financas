# Engenharia reversa do APK Minhas Finanças 7.2.3

## Evidências técnicas extraídas do APK autorizado

- SHA-256 do arquivo examinado: `1fc4b594dacb43b02b178f5f67690a3ae4dc4ab4d3ef6d07c0654f6a9c396b46`
- 3.379 entradas no pacote e 7 arquivos `.dex`.
- 7.008 definições de classe pertencentes ao namespace `cicero/minhasfinancas`.
- 40.419 métodos com corpo de bytecode identificado nos DEX.
- 202 assinaturas de Activity observadas em referências do aplicativo; essa contagem é de assinaturas, e não de 202 páginas totalmente independentes.
- 3 bancos SQLite incluídos; o principal contém **28 tabelas e 360 colunas**.
- 253 arquivos SQL distribuídos por 29 grupos.
- Outras **93 colunas** referenciadas em operações `INSERT` que não existem no SQLite inicial embutido; a migração gerada inclui essas colunas. **Seus tipos SQL são inferidos** a partir de nomes/uso e necessitam verificação contra a versão efetiva em execução.

A auditoria é reproduzível com `python scripts/analyze_apk.py "/caminho/Minhas Finanças_7.2.3.apk"`.

## Correspondência identificada

| Funcionalidade Android | Evidência dentro do APK | Módulo web |
|---|---|---|
| Resumo | `activity/menu/ResumoChartActivity` | Resumo, indicadores, evolução e discriminação |
| Contas | `activity/conta/ContasActivity`, `bll/Contas`, `assets/SQL/Contas/*`, `assets/SQL/ContasSaldo/*` | Contas e cálculos mensais |
| Receitas | `activity/receita/NovaReceitaActivity`, `bll/Receitas`, `assets/SQL/Receitas/*` | Receitas efetivadas e pendentes |
| Despesas | `activity/despesa/NovaDespesaActivity`, `bll/Despesas`, `assets/SQL/Despesas/*` | Despesas e categorias |
| Transferências | `activity/transferencia/NovaTransferenciaActivity`, `bll/Transferencias` | Movimento entre contas |
| Cartões | `activity/cartao_credito/CartoesCreditoActivity`, `HistoricoFaturasActivity` | Cartões, parcelas e fatura mensal básica |
| Orçamentos | `activity/orcamentos/*` | Meta e acompanhamento |
| Objetivos | `activity/objetivo/*` | Meta e depósitos |
| Relatórios | `activity/relatorio/*` | Resumos e gráficos |

## O que foi portado

O código em `src/core.js` trabalha diretamente com os **nomes e campos de tabelas do APK**, não com uma tabela inventada de "transactions". O `database/schema-map.js` representa o esquema inicial e `database/runtime-columns.js` documenta a ampliação observada nos SQL.

Regras atuais: receitas e despesas pagas/pendentes, transferência contábil com crédito e débito, saldo mensal com transporte a partir de `contas_saldo`, compra parcelada com soma exata dos centavos, posição da parcela segundo o dia de fechamento, orçamento mensal e objetivos.

As telas web são **implementações novas baseadas nas estruturas e capturas de referência**. O bytecode Android **não é diretamente executável no navegador**; toda dependência Android precisa ser substituída. Portanto, este projeto é uma portabilidade por engenharia reversa, **não** uma conversão automática literal do executável.

## Limitações atuais e pendências (não omitir na apresentação)

- Os métodos DEX foram indexados, mas não foram integralmente decompilados em Java/Kotlin nem traduzidos individualmente. Há código ofuscado.
- A reprodução visual foi iniciada, mas não passou por inspeção comparativa completa no Android e em diferentes telas móveis.
- A recorrência de despesas e receitas fixas, juros, parcelamentos com todas as nuances de fatura, conciliações, importações, sincronização Open Finance, notificações e relatórios complexos ainda precisam de paridade funcional.
- Os 93 tipos inferidos e as demais operações de leitura/atualização podem exigir campos ou índices adicionais.
- Persistência local funciona no navegador; persistência Cloudflare D1 exige criar o banco, executar as migrações e configurar os segredos, seguida de teste de ponta a ponta.
- A autenticação na nuvem atual é **usuário único de demonstração**. Não usar como serviço financeiro público multiusuário nem inserir dados sigilosos sem arquitetura própria de usuários, isolamento e backup.

## Banco e Cloudflare

1. Criar um banco Cloudflare D1 e um binding `DB` no projeto Pages.
2. Executar `npm run schema` após instalar as dependências.
3. Executar os SQL gerados, **na ordem**: `0002_original_schema.sql` e `0003_runtime_columns.sql` (use `npx wrangler d1 execute <nome> --remote --file=<arquivo>`).
4. Configurar os secrets do Pages: `OMF_APP_PASSWORD` e `OMF_COOKIE_SECRET` (valores distintos; o segundo deve ser aleatório, longo).
5. Implantar pela branch `main`; entrar em Backup para autenticar e sincronizar.
6. Não habilitar a sincronização com dados reais sem testar migração, sessões, conflitos e rotina de backup.

A API usa sessões `HttpOnly`, `Secure`, `SameSite=Strict`, e admite operações de D1 apenas quando o binding e os segredos estão configurados. Ela não torna o frontend multiusuário.

## Licenciamento

A autorização para análise e adaptação informada pelo responsável pelo trabalho acadêmico não comprova a cessão de direitos autorais do código original. Este repositório **não distribui o APK ou artefatos visuais proprietários**. Confirme por escrito a autorização para disponibilizar publicamente qualquer elemento protegido da versão original.
