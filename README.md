# Finn & Bones — reconstrução em Godot 4

Projeto de preservação e reconstrução; estado atual é uma fatia vertical incompleta. Para trabalhar em outro computador, clone este repositório e importe `project.godot` na Godot 4.7.2. Pressione F6/F5 para executar. As tabelas são lidas de `preservation/`; quadros e ícones usados pelo jogo estão em `private/`. Instale a Godot separadamente: ferramentas e instaladores não estão no repositório.

Exemplos de teste, a partir da raiz do projeto, com o executável da Godot acessível como `godot`:

```text
godot --headless --path . --script res://tests/test_core.gd
godot --headless --path . --script res://tests/test_timeline.gd
godot --headless --path . --script res://tests/test_vertical_slice.gd
```

`preservation/original` contém o pacote histórico e sua extração; `preservation/analysis` e `preservation/decompiled` contêm dados e código recuperados; `preservation/documentation` contém registros anteriores. `private/` contém cópias dos recursos convertidos para uso pelo protótipo. Este repositório público contém recursos e código do jogo original por solicitação do proprietário. A licença dos recursos originais pertence aos respectivos titulares.

Fatia atual: combate automático, primeira fase, transição limitada à segunda, inventário e equipamentos parciais. Painéis são provisórios e ainda faltam mistura geral, consumíveis, persistência, recompensas completas e validação visual sistemática. Os scripts de reexportação foram criados para o acervo completo no computador original e ainda têm caminhos locais; não são necessários para executar as imagens já incluídas. Consulte `docs/PROGRESSO.md` e `docs/ARQUITETURA_E_LIMITACOES.md`.


Localização: inglês, português brasileiro e espanhol. Veja docs/LOCALIZACAO.md para configuração, testes, limites e inclusão de novos idiomas.
