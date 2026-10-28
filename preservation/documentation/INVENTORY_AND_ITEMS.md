# Inventário e itens

`Inventory.as`: 12 slots, persistência por slot em SaveSystem, além de Trash. `config.di`: inventário inicial SwordStarter e HPPotionSmall; potion_limit=3. `analysis/items.json` reproduz 83 linhas originais, com nomes e valores como strings, incluindo categoria, MovieClip, modificadores, elemento, tempo, duração e limite. A semântica completa de equipagem e duração exige rastreamento adicional em Gear, Slot e modificadores. Não se inventou classificação de raridade.

Gear.as declara slots de arma, escudo e dois equipamentos; mudanças removem efeitos do item anterior e aplicam efeitos do novo via StatsEffectGuardian; cada slot é salvo. Gear permite bloqueio durante ações. 

