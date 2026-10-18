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
- Aplicar **primeiro** `database/migrations/0002_original_schema.sql` e **depois** `0003_runtime_columns.sql`.
- Definir `OMF_APP_PASSWORD` e `OMF_COOKIE_SECRET` como secrets do Pages.
- Na tela Backup: entrar na nuvem, carregar dados D1 para obter a versão, então salvar modificações.

**Não copie segredos no repositório.** O arquivo `wrangler.toml` não contém IDs reais de banco.

## Conteúdo da engenharia reversa

O inventário DEX/SQLite, as divergências entre a base inicial e os comandos SQL do APK, a matriz de módulos, as limitações e as instruções de segurança estão em [docs/ENGENHARIA_REVERSA.md](docs/ENGENHARIA_REVERSA.md).

A estrutura derivada do SQLite inclui 28 tabelas com 360 colunas originais e 93 colunas adicionais identificadas nos scripts SQL. A API opera diretamente nessas tabelas, quando configurada.

## Estado

**Em desenvolvimento — não é uma reprodução integral validada.** As funções centrais possuem testes automatizados; as dependências exclusivas do Android e recursos de Open Finance ainda não foram reproduzidos. O banco remoto depende de configuração e testes no Cloudflare.
