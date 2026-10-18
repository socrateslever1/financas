# Open Minha Finanças

Projeto acadêmico de **portabilidade web por engenharia reversa autorizada** do aplicativo Minhas Finanças 7.2.3.

[![GitHub Actions](https://github.com/socrateslever1/financas/actions/workflows/check.yml/badge.svg)](https://github.com/socrateslever1/financas/actions/workflows/check.yml)

## Desenvolvimento

```bash
npm install
npm test
npm run dev
```

O frontend usa Vite e JavaScript com módulos próprios. Os dados ficam localmente no navegador até a integração Cloudflare D1 ser configurada.

## Cloudflare Pages

- Repositório: `socrateslever1/financas`.
- Build: `npm run build`.
- Diretório: `dist`.
- Branch: `main`.
- Vincular um banco D1 sob o nome `DB` no ambiente de produção e nos previews, se necessários.
- Gerar SQL com `npm run schema`.
- Aplicar as migrações **em ordem**: `0002_original_schema.sql`, `0003_runtime_columns.sql` e `0004_apk_runtime_tables.sql` (a terceira é gerada por `npm run schema`).
- Definir `OMF_APP_PASSWORD` e `OMF_COOKIE_SECRET` como secrets do Pages.
- Na tela Backup: entrar na nuvem, carregar dados D1 para obter a versão, então salvar modificações.

**Não copie segredos no repositório.** O arquivo `wrangler.toml` não contém IDs reais de banco.

## Conteúdo da engenharia reversa

O inventário DEX/SQLite, as divergências entre a base inicial e os comandos SQL do APK, a matriz de módulos, as limitações e as instruções de segurança estão em [docs/ENGENHARIA_REVERSA.md](docs/ENGENHARIA_REVERSA.md).

A estrutura derivada do SQLite inclui 28 tabelas com 360 colunas originais e 93 colunas adicionais identificadas nos scripts SQL. A API opera diretamente nessas tabelas, quando configurada.

## Estado

**Em desenvolvimento — não é uma reprodução integral validada.** As funções centrais possuem testes automatizados; as dependências exclusivas do Android e recursos de Open Finance ainda não foram reproduzidos. O banco remoto depende de configuração e testes no Cloudflare.

## Verificação de outubro de 2026

Foi realizado um teste externo com dados fictícios no Cloudflare, que comprovou navegação e persistência local. Esse teste detectou lançamento de receita na conta Investimentos, excluída dos totais de contas. Foram corrigidas a escolha padrão da conta nos formulários e a exclusão de contas ignoradas nos totais. As correções possuem testes automatizados; a interface atualizada ainda precisa de reteste externo e a persistência D1 ainda não foi validada.

**Não apresentar esta versão como equivalência integral do APK.** Há módulos e regras nativas pendentes.
