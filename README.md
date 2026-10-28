# Protótipo de reconstrução — Godot 4

Execute no computador que contém o acervo:

```powershell
& 'C:\Users\canal\AppData\Local\Programs\Godot\4.7.2\Godot_v4.7.2-stable_win64_console.exe' --path 'C:\Projetos\FinnAndBonesPreservation\reconstruction'
```

Testes:

```powershell
& 'C:\Users\canal\AppData\Local\Programs\Godot\4.7.2\Godot_v4.7.2-stable_win64_console.exe' --headless --path 'C:\Projetos\FinnAndBonesPreservation\reconstruction' --script 'res://tests/test_core.gd'
& 'C:\Users\canal\AppData\Local\Programs\Godot\4.7.2\Godot_v4.7.2-stable_win64_console.exe' --headless --path 'C:\Projetos\FinnAndBonesPreservation\reconstruction' --script 'res://tests/test_timeline.gd'
& 'C:\Users\canal\AppData\Local\Programs\Godot\4.7.2\Godot_v4.7.2-stable_win64_console.exe' --headless --path 'C:\Projetos\FinnAndBonesPreservation\reconstruction' --script 'res://tests/test_vertical_slice.gd'
```

O protótipo lê dados e sprites do acervo por caminhos locais declarados nos scripts. Os PNGs convertidos ficam em `private/`, ignorado pelo Git. Se essa pasta estiver vazia, gere os recursos locais nesta ordem: `--headless --path reconstruction --script res://scripts/export_private_frames.gd` e depois `--headless --path reconstruction --script res://scripts/export_visual_assets.gd`. Não publique conteúdo protegido.

Esta fatia vertical oferece combate automático e uma tela de inventário estruturada. Selecione um item e use **Equipar selecionado**; armas e escudos são mostrados em camadas separadas no Finn. Os ícones de itens e molduras de slot vêm dos sprites extraídos; painéis, botões e composição continuam temporários, não uma reprodução fiel. Para conferir: equipe `SwordStarter`, troque por outra arma disponível, equipe/remova `ShieldSimple` e entre em combate. A fase 2 mantém a transição automática entre os dois encontros. Mistura completa, receitas customizadas, progressão posterior, áudio, consumíveis e persistência continuam pendentes.
