# Localização

O jogo usa o autoload `Localization` (`scripts/localization.gd`) com as APIs nativas `Translation` e `TranslationServer`; cenas usam `tr()`. `translations/messages.csv` contém traduções próprias: **176 chaves** (84 textos de interface/bancada, 83 nomes de itens e 9 nomes de personagens/inimigos), com en, pt_BR e es. IDs de itens, receitas e inimigos permanecem inalterados. Há textos de interface referentes a funcionalidades ainda não implementadas, apenas quando aparecem na bancada existente.

Na primeira execução sem preferência válida, o idioma é escolhido pelo idioma do sistema; idiomas não disponíveis usam inglês. A seleção fica no menu principal e no botão Configurações durante o jogo. A mudança atualiza a interface e mensagens dinâmicas sem reiniciar; a preferência é gravada em `user://language.cfg`, separada de dados de campanha. Regiões espanholas usam `es`; `pt_BR` usa português brasileiro. A opção `pt_PT` não é presumida como pt_BR e usa inglês até haver uma tradução correspondente.

## Acrescentar idioma

1. Adicione uma coluna ao CSV, com um código de localidade Godot na primeira linha (por exemplo, `fr`). Preencha todas as 176 linhas; preserve as chaves e os marcadores `%s` e `%d` na ordem e quantidade correspondentes.
2. Opcionalmente, adicione a linha `LANGUAGE.NAME.fr`, com o nome do idioma em todas as colunas. Se faltar, o seletor mostra o próprio código. Os seletores leem as colunas automaticamente; não é preciso alterar gameplay.
3. Execute `tests/test_localization.gd`, `tests/test_localization_layout.gd`, `tests/test_translation_widths.gd` e testes de gameplay com a Godot. Atualize a expectativa de colunas e a contagem de chaves no teste de catálogo ao adicionar o idioma e sua linha de nome. Ajuste testes de largura para a nova localidade.

`translations/.gdignore` evita que o importador de CSV da Godot gere arquivos derivados; o autoload lê o CSV e registra recursos Translation nativos em tempo de execução. `.gitignore` abre exceção somente para este CSV; CSVs do acervo continuam ignorados no projeto original.

## Pendências e limites

- Os nomes ingleses de `Recipe` e `BossPendant` não foram encontrados em `locale.txt`; os rótulos "Recipe" e "Boss Pendant" e suas traduções são descritivos provisórios, não nomenclatura original confirmada. Os nomes em português e espanhol dos demais itens e inimigos são traduções de trabalho, sem validação oficial de dublagem ou terminologia.
- O jogo original completo contém textos que ainda não existem na versão reconstruída; eles não estão neste catálogo. Os idiomas estão completos apenas para as chaves atualmente implementadas nas duas cenas.
- Recursos atuais `private/ui/inventory_slot.png`, `weapon_slot.png` e `shield_slot.png` foram inspecionados e são molduras sem palavras visíveis. `private/gear/recipe.png` contém marcas gráficas pequenas; não foi determinado se são texto linguístico. Não foram alterados.
- No SWF `screens.swf`, os textos extraídos `assets/other/screens/texts/238.txt` (MIX), `245.txt` (Level) e `278.txt`/`280.txt`/`282.txt` (recompensas) indicam conteúdos a localizar antes de usar telas ou sprites rasterizados correspondentes. É preciso verificar se cada exportação os incorpora como pixels ou mantém texto separado; nenhuma versão localizada de imagem foi gerada.
- Na versão atualizada do GitHub, o menu usa `private/ui/main_menu.png`: a imagem contém o logotipo Finn & Bones, mantido como marca, enquanto Novo jogo/Continuar são textos dinâmicos. `private/ui/inventory_panel.png` e os atlas de vida não apresentam palavras legíveis na inspeção realizada. O desenho do caderno e da receita contém marcas pequenas não identificadas como texto linguístico. A interface usa recorte com reticências e tooltip em rótulos que não cabem, além de rolagem vertical nos painéis.
- Testes headless conferem geometria em 700×500, 249 nomes em botões de recompensa e cobertura de fonte para acentos, mas não substituem inspeção visual nas três línguas. A captura automática de janela falhou neste ambiente em sessões anteriores.
