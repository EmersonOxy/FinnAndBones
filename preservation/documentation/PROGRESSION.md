# Progressão

`dungeons.csv` tem 32 linhas de configuração, com até dez entradas de inimigo, dez de loot e três camadas; não se afirma que cada linha equivale a uma fase acessível sem verificar o mapa. `Dungeon.initializeFights` cria lutas na ordem dos dados; `wonFight` salva fase concluída após o último inimigo. `firstLoot.csv` é usado apenas se a fase não foi concluída (`DungeonFactory.getFirstLoot`). `finnXP.csv` contém 20 limiares. `LevelingStragegy.levelUp` aplica delta arredondado de base*mod^(novo-1) menos base*mod^(anterior-1), com tratamento especial para nível anterior <=1. Multiplicadores em config.di; conferir regras de desbloqueio e conclusão do chefe.

CONFIRMADO em main_game/map/Map.as: cria níveis 1–25 comuns, 26–30 especiais e 31–32 LegendaryLevel (gelo e fogo); conecta 1→2→...→25 e ramificações 4→26→6, 15→27→16, 19→28→20, 23→29→30→24. O primeiro é desbloqueado; fases concluídas desbloqueiam correlativas. Níveis lendários dependem de datas de bônus; regras completas ainda exigem revisão. Loot.as monta três slots, priorizando o conjunto de primeira conclusão e preenchendo o restante com a tabela da masmorra; conferir ProbabilisticSet antes de estimar probabilidades.

BossDungeon.idBossLevel é 25. Loot usa ProbabilisticSet.pop: seleção ponderada proporcional aos pesos restantes, removendo a entrada selecionada; repetem-se escolhas até preencher três slots. DungeonConfigParser interrompe a leitura na primeira entrada null; a tabela bruta não deve ser interpretada diretamente como distribuição completa. Ver util/ProbabilisticSet.as e main_game/dungeon/Loot.as.


XpCalculator soma XP dos inimigos derrotados. Os bônus de mistura e crítico são round(quantidade × XP requerido atual × percentual / 100), com config mix=5 e critical=10; é necessário conferir quando e quantas vezes os chamadores aplicam esses bônus.

DungeonStats conta conclusões de mistura e golpes críticos enquanto ativo e soma XP de combate, crítico e mistura ao calcular XP da masmorra (getDungeonExperience).
