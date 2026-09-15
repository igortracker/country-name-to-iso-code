# Guia rápido — publicar no GitHub e submeter à Galeria

## 1. Criar o repositório no GitHub

Crie um repositório **público** chamado `country-name-to-iso-code`
(em github.com → New repository). **Não** marque para adicionar README/LICENSE,
pois eles já estão aqui. Deixe as **Issues habilitadas** (padrão).

## 2. Subir os arquivos (linha de comando)

Dentro da pasta do projeto:

```bash
git init
git add .
git commit -m "Versão inicial: Country Name to ISO Code (variável server-side)"
git branch -M main
git remote add origin https://github.com/igortracker/country-name-to-iso-code.git
git push -u origin main
```

## 3. Pegar o SHA e ajustar o metadata.yaml

```bash
git rev-parse HEAD        # copie o SHA completo que aparecer
```

- Edite `metadata.yaml`:
  - troque `igortracker` nas URLs `homepage` e `documentation`;
  - cole o SHA no campo `sha`.
- Commit e push:

```bash
git add metadata.yaml
git commit -m "metadata.yaml: define homepage, documentation e SHA da versão inicial"
git push
```

> Se preferir, use o SHA **deste** commit do metadata como versão inicial —
> o importante é que o `sha` aponte para um commit que contenha o `template.tpl`
> que você quer publicar (todos contêm, então qualquer um serve para a v1).

## 4. Submeter à Galeria

1. Acesse **https://tagmanager.google.com/gallery** logado no GitHub com acesso ao repo.
2. Menu **⋮ → Submit Template**.
3. Cole a URL do repositório e clique em **Submit**.
4. Aguarde a validação e a revisão do Google.

## Checklist final antes de submeter

- [ ] `template.tpl`, `metadata.yaml` e `LICENSE` na **raiz** e na branch **main**
- [ ] `LICENSE` com nome em MAIÚSCULAS e conteúdo só Apache 2.0
- [ ] Linha `Copyright` do LICENSE com ano e titular corretos
- [ ] `template.tpl` com `categories` no `___INFO___` (aqui: `UTILITY`)
- [ ] `metadata.yaml` com `homepage`, `documentation` e `versions` (SHA correto)
- [ ] Repositório **público** e com **Issues habilitadas**
- [ ] Apenas **um** `template.tpl` no repositório
