# Changelog

Todas as mudanças relevantes deste template são documentadas aqui.
O versionamento oficial que a Galeria usa fica no `metadata.yaml` (via SHA de commit);
este arquivo é apenas um histórico legível para humanos.

## [1.0.0] - Versão inicial
### Adicionado
- Variável server-side que converte nome de país (PT, EN e variações comuns)
  em código ISO 3166-1 alpha-2 minúsculo.
- Normalização da entrada: minúsculo → remoção de acentos → remoção de
  espaços, pontuação e caracteres especiais.
- Parâmetro de valor padrão (fallback) para entradas vazias ou não encontradas.
- Suíte de testes cobrindo acentos, maiúsculas, inglês, hífens, apóstrofos,
  pontuação, espaços extras, variações comuns, fallback e entrada vazia.
