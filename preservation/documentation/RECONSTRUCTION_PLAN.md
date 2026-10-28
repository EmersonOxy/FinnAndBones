# Plano Godot 4

1. Completar exportação e inventário; verificar player original e capturar os fluxos.
2. Conferir fórmula de dano e casos de arredondamento contra P-code e ensaios, controlando RNG.
3. Criar domínio GDScript sem apresentação: FighterStats, DamageCalculator, Fight, Inventory, Gear, Mixer, Dungeon e SaveRepository; usar RNG injetável e dados em arquivos locais validados.
4. Reproduzir regras de nível, loot, desbloqueios e persistência após rastrear o código e confrontar o original. A persistência nova deve ser versionada, sem afirmar compatibilidade com SharedObject.
5. Mapear símbolo/ID, cenas e animações somente após validar os recursos; testar resolução e tempos. Fazer comparação de cenários, dados e capturas em Godot 4. Não iniciar reconstrução visual completa antes dessas verificações.
