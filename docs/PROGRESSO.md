# Fase 3: integração de combate

Em 28/10/2026, retomada a integração já iniciada no projeto Godot 4.7.2, sem descartar as alterações existentes.

Concluído nesta retomada:
- Combate automático orientado pelos marcadores recuperados: Finn com espada inicia no quadro 25, atinge no 38 e encerra no 58; o inimigo normal atinge no quadro 17.
- Dano aplicado uma única vez no contato; o próximo turno aguarda o fim do golpe e da reação do alvo, inclusive evasão e derrota.
- A fase 2 carrega os dois encontros declarados nos dados; a vitória no primeiro inicia automaticamente o segundo, e só o resultado do segundo encerra a fase.
- Quadros privados do Finn e do esqueleto continuam locais e ignorados pelo Git.
- Godot 4.7.2 inicializa em modo headless; testes de lógica, cronograma e transição passam.

Parcial: interface e animações visuais ainda são provisórias; recompensas da fase 2 ainda não usam o sistema regular de loot. Pendente: fases posteriores, mistura completa, consumíveis, persistência, menus e validação visual sistemática contra o original. Marcadores e fluxo foram conferidos com `analysis/animation_timing.json`, `Fight.as`, `HitAnimation.as`, `HurtAnimation.as` e `Dungeon.as`.

## Camada visual — retomada

- Causa do ciclo: a tela avançava o clipe inteiro de idle do `FinnSword` (`1..22`) como se fosse uma animação corporal; esses frames também avançam as subcamadas de espada/escudo. O original fixa cada subclipe pelo rótulo `MovieClip` do equipamento (`FinnView`, `SwordModifier`, `ShieldModifier`).
- Correção: exportação de quadros-base do Finn sem as subcamadas animadas, e ícones separados escolhidos pelo `MovieClip` do item lógico equipado. O Finn recebe apenas a arma e o escudo que constam em `game.gear`; a colocação das imagens é aproximada, não a montagem vetorial original por frame.
- UI agora usa `PanelContainer`, `GridContainer`, `Button`, `TextureRect`, `ProgressBar` e `Label`, em vez de desenhar painéis/textos com `_draw`. Molduras de slot e ícones de itens são arte extraída identificada; composição, botões e estilo geral são provisórios.
- O fundo completo da tela de inventário e o menu foram localizados (`assets.Inventory`/`assets.MainMenu`), mas ainda não foram montados como telas fiéis. Sem testes automatizados ou visuais executados nesta retomada; validação manual fica para a próxima sessão.

## Reconstrução visual — combate (28/10/2026)

- O `background/1.png` usado pela cena era uma textura vazia de 1×1. O cenário agora usa as camadas originais `assets.Layer_1`, `assets.Layer_2` e `assets.Layer_3` de `backgrounds.swf`, na ordem de profundidade do `BackgroundView`.
- Finn e o esqueleto foram ampliados/reposicionados; os overlays de arma e escudo continuam ligados a `game.gear`.
- As barras de HP usam os 100 frames originais dos sprites `Bar` 634/647 de `screens.swf`; a regra de cálculo de HP não foi alterada. Feedback de dano, crítico e esquiva foi adicionado à cena.
- Validação: inicialização headless e `test_core`, `test_scene`, `test_timeline`, `test_vertical_slice` passaram.

Pendente: validar a composição em janela Godot, exportar o restante dos frames de Finn em resolução maior, integrar efeitos originais de `combat_fx.swf` e concluir telas de inventário, vitória e derrota.
