# Protótipo de reconstrução — Godot 4

Execute no computador que contém o acervo:

```powershell
& 'C:\Users\canal\AppData\Local\Programs\Godot\4.7.2\Godot_v4.7.2-stable_win64_console.exe' --path 'C:\Projetos\FinnAndBonesPreservation\reconstruction'
```

Testes:

```powershell
& 'C:\Users\canal\AppData\Local\Programs\Godot\4.7.2\Godot_v4.7.2-stable_win64_console.exe' --headless --path 'C:\Projetos\FinnAndBonesPreservation\reconstruction' --script 'res://tests/test_core.gd'
```

O protótipo lê os dados em `../analysis` e firstLoot.csv dentro do acervo original, por caminho absoluto declarado em `scripts/data_store.gd`, sem modificá-los. Não é portátil enquanto esse caminho não for configurado. Nenhum material original foi copiado ao projeto; `.gitignore` bloqueia formatos comuns, mas exige revisão manual de qualquer arquivo novo antes de versionar. Não publicar conteúdo protegido.

O protótipo é uma bancada com controles e textos temporários, não uma reprodução visual. Comece a missão, equipe a espada no slot weapon e avance os ataques manualmente. O teste de mistura de SwordStarter + FireFlame existe no modelo e teste, mas não há interface de mistura e FireFlame não é disponibilizado no primeiro encontro. A pesquisa consulta todas as 82 receitas; não trata resultados customizados nem regras gerais. Não há salvamento, animações, áudio, consumíveis, avanço de fases, ritmo original, modificador de HP máximo, conclusão e loot regular. Ao repetir a fase, o estado é apenas da sessão e não reproduz persistência. Não confundir com o original.
