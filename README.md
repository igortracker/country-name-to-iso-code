# Country Name to ISO Code — Variável server-side para o Google Tag Manager

Variável **server-side** (sGTM) que recebe o **nome de um país** — em português, inglês
ou variações comuns — e retorna o **código ISO 3166-1 alpha-2 em minúsculo**
(ex.: `Brasil` → `br`, `Germany` → `de`, `EUA` → `us`).

A entrada é normalizada antes da consulta, evitando erros de digitação,
acentuação, pontuação e espaçamento.

> Criada por **@igor.tracker**.

---

## Índice

- [O que ela faz](#o-que-ela-faz)
- [Parâmetros](#parâmetros)
- [Como a normalização funciona](#como-a-normalização-funciona)
- [Cobertura e valor de retorno](#cobertura-e-valor-de-retorno)
- [Permissões](#permissões)
- [Instalação a partir da Galeria](#instalação-a-partir-da-galeria)
- [Instalação manual (import do .tpl)](#instalação-manual-import-do-tpl)
- [Exemplo de uso](#exemplo-de-uso)
- [Testes](#testes)
- [Publicar / submeter à Galeria](#publicar--submeter-à-galeria)
- [Publicar novas versões](#publicar-novas-versões)
- [Estrutura do repositório](#estrutura-do-repositório)
- [Suporte](#suporte)
- [Licença](#licença)

---

## O que ela faz

Recebe um nome de país e devolve o respectivo código ISO 3166-1 alpha-2
(dois caracteres, minúsculo). É útil para padronizar dados de país antes de
enviá-los a plataformas de conversão, CRMs, data warehouses ou qualquer
destino que espere o código ISO em vez do nome por extenso.

Tudo roda dentro do JavaScript sandbox do sGTM. Não faz chamadas externas
nem lê o corpo do evento diretamente — apenas transforma o valor que você
passar para o parâmetro de entrada.

## Parâmetros

| Parâmetro | Nome interno | Obrigatório | Descrição |
| --- | --- | --- | --- |
| **Nome do país** | `countryName` | Sim | Nome do país em PT, EN ou variação comum. Pode ser uma variável, ex.: `{{DLV - country}}` ou uma variável baseada em `getEventData`. |
| **Valor padrão (fallback)** | `defaultValue` | Não | Valor retornado quando o país não for encontrado ou a entrada estiver vazia. Deixe em branco para retornar `undefined`. |

## Como a normalização funciona

Antes de consultar a tabela de-para, a entrada passa por três etapas, nesta ordem:

1. Converte para **minúsculo**.
2. Remove **acentos** (á, ã, ç, ñ, etc.).
3. Remove **tudo que não for letra `a-z` ou número `0-9`** — espaços, hífens,
   apóstrofos, pontos e quaisquer caracteres especiais.

Assim, entradas como `"  Costa   Rica  "`, `"U.S.A."`, `"Guiné-Bissau"` e
`"Côte d'Ivoire"` são reconhecidas corretamente.

## Cobertura e valor de retorno

- Cobre os países com chaves em **português, inglês e variações comuns**
  (ex.: `EUA`, `USA`, `Estados Unidos`, `America` → `us`).
- Retorna sempre o código **ISO 3166-1 alpha-2 em minúsculo** (ex.: `br`, `pt`, `de`).
- Se a entrada estiver vazia ou o país não for encontrado, retorna o
  **valor padrão (fallback)**; se nenhum fallback for informado, retorna `undefined`.

## Permissões

**Nenhuma permissão especial é necessária.** A variável não usa `getEventData`,
não faz requisições de rede e não acessa armazenamento — apenas a API
`makeString` da biblioteca padrão do sandbox.

## Instalação a partir da Galeria

> Disponível após a aprovação da submissão pelo Google.

1. No seu **container server-side**, vá em **Templates**.
2. Em **Variable Templates**, clique em **Search Gallery**.
3. Busque por **"Country Name to ISO Code"** e clique em **Add to workspace**.
4. Crie uma nova variável do tipo do template e configure os parâmetros.

## Instalação manual (import do .tpl)

Enquanto a submissão não for aprovada, ou para testar localmente:

1. No container **server-side**, vá em **Templates → Variable Templates → New**.
2. No editor de templates, menu **⋮ → Import**.
3. Selecione o arquivo [`template.tpl`](./template.tpl) deste repositório.
4. Salve. Depois crie uma variável baseada nesse template.

## Exemplo de uso

1. Crie uma variável baseada no template.
2. Em **Nome do país**, passe a variável de origem, ex.: `{{DLV - country}}`
   ou uma variável de `getEventData` (ex.: `user_data.address.country`).
3. (Opcional) Em **Valor padrão**, defina um fallback, ex.: `zz`.
4. Use a variável resultante onde precisar do código ISO, ex.: no parâmetro
   `country` de uma tag de conversão.

| Entrada | Saída |
| --- | --- |
| `Brasil` | `br` |
| `AFEGANISTAO` | `af` |
| `Germany` | `de` |
| `Guiné-Bissau` | `gw` |
| `Côte d'Ivoire` | `ci` |
| `U.S.A.` | `us` |
| `  Costa   Rica  ` | `cr` |
| `Narnia` (com fallback `xx`) | `xx` |
| `` (vazio, sem fallback) | `undefined` |

## Testes

O `template.tpl` inclui uma suíte de testes no bloco `___TESTS___`, executável
pela aba **Tests** do editor de templates do GTM. Os cenários cobrem português
com acento, maiúsculas, nomes em inglês, hífens, apóstrofos, pontuação,
espaços extras, variações comuns, fallback e entrada vazia.

Para rodar: abra o `template.tpl` no editor, vá na aba **Tests** e clique em
**Run all tests**.

## Publicar / submeter à Galeria

Requisitos oficiais do Google (arquivos na **raiz** e na branch **main**):

- ✅ `template.tpl` — com entrada `categories` no bloco `___INFO___` (aqui: `UTILITY`)
  e o bloco `___TERMS_OF_SERVICE___` presente (equivale ao aceite dos Termos no editor).
- ✅ `metadata.yaml` — com `homepage`, `documentation` e `versions` (SHA + changeNotes).
- ✅ `LICENSE` — nome em MAIÚSCULAS, conteúdo **exclusivamente** Apache 2.0.
- ✅ `README.md` — opcional, mas recomendado (este arquivo).
- ✅ **Issues habilitadas** no repositório (a Galeria linka para elas).

Passo a passo:

1. Crie o repositório no GitHub (público) e suba estes arquivos na branch `main`.
2. Edite o `metadata.yaml`: troque `igortracker` e cole o **SHA do primeiro commit**
   no campo `sha`. Faça commit dessa alteração.
3. Acesse **[tagmanager.google.com/gallery](https://tagmanager.google.com/gallery)**.
4. Clique no menu **⋮ → Submit Template**.
5. Cole a **URL do repositório** e clique em **Submit**.
6. Se a validação passar, o template entra em revisão e costuma aparecer na
   Galeria em alguns dias. Nem todo template é publicado — ele precisa seguir o
   [Style Guide](https://developers.google.com/tag-platform/tag-manager/templates/style)
   e não pode duplicar um template já existente.

> **Não edite o `template.tpl` à mão.** Para alterar o template, importe-o no
> editor do GTM, faça as mudanças, exporte novamente e substitua o arquivo.

## Publicar novas versões

1. Faça as alterações e commite (idealmente exportando o `.tpl` do editor).
2. Copie o **SHA** do commit final.
3. Adicione uma nova entrada no **topo** de `versions` no `metadata.yaml`,
   com `sha` e `changeNotes`, mantendo a ordem cronológica inversa.
4. Commite a mudança do `metadata.yaml`. A atualização aparece na Galeria,
   normalmente, em 2 a 3 dias.

```yaml
homepage: "https://github.com/igortracker/country-name-to-iso-code"
documentation: "https://github.com/igortracker/country-name-to-iso-code#readme"
versions:
  # Versão mais recente
  - sha: SHA_DA_NOVA_VERSAO
    changeNotes: Descrição das mudanças.
  # Versões anteriores
  - sha: SHA_DA_VERSAO_INICIAL
    changeNotes: Versão inicial.
```

## Estrutura do repositório

```
country-name-to-iso-code/
├── template.tpl        # Template exportado do GTM (obrigatório)
├── metadata.yaml       # Versões + metadados da Galeria (obrigatório)
├── LICENSE             # Apache 2.0 (obrigatório)
├── README.md           # Esta documentação (recomendado)
├── CHANGELOG.md        # Histórico legível de mudanças (opcional)
└── .github/
    └── ISSUE_TEMPLATE/ # Modelos de bug report / feature request (opcional)
```

## Suporte

Encontrou um bug ou tem uma sugestão? Abra uma
**[issue](../../issues)** neste repositório. Mantenha as Issues habilitadas
e as notificações por e-mail ativas para acompanhar o processo de revisão.

## Licença

Distribuído sob a licença **Apache 2.0**. Veja o arquivo [LICENSE](./LICENSE).
