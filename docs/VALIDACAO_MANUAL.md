# Validação manual comparativa

A confirmação de funcionamento do original veio do usuário; os cenários abaixo ainda não foram observados sistematicamente. Na Godot, use os controles identificados no README. A sequência visual e os tempos são diferentes e ainda não devem ser avaliados como fiéis.

1. **Atributos e espada inicial.** No original, veja o ataque de Finn sem arma e ao equipar SwordStarter. Na Godot, selecione `01: SwordStarter`, slot `weapon`, e clique em equipar: a bancada deve passar de ataque 5 para 15; remova para voltar a 5. Origem: characters.csv, items.csv e Gear.as. Confirme se o original apresenta os mesmos números.
2. **Primeiro inimigo e turnos.** Entre na primeira missão no original; observe HP e ordem dos golpes. Na Godot, inicie a missão: enemy1_normal inicia com 38 HP e Finn ataca primeiro; cada clique executa um golpe e alterna. No original, registre a ordem e o intervalo entre os golpes; a Godot não reproduz o tempo original.
3. **Dano inicial.** Com espada inicial, contra o primeiro inimigo de defesa 2 e sorte igual, a fórmula estática na bancada produz dano entre 12 e 14, sujeito a sorteios; sem espada, 3. Registre uma série de golpes e os atributos exibidos no original. Não se considera uma amostra curta prova da distribuição.
4. **Recompensas da primeira conclusão.** No original, registre quais opções aparecem e se é possível escolher apenas algumas. Na bancada são sorteados sem reposição MaxHPRing, ShieldSimple e LuckPotionSmall, e o usuário pode coletá-los; a regra de escolha/coleta da interface original ainda não foi validada, portanto esta parte é provisória.
5. **Mistura.** No original, combine SwordStarter com FireFlame e registre ordem, duração e resultado. A consulta da Godot para esses IDs mostra SwordStarterFire; uma operação de modelo automatizada verifica o consumo, mas não há interface funcional de mistura. A duração nominal calculada no código é 2 segundos; verificar comportamento real.
6. **Persistência e progressão.** No original, conclua uma missão, feche e reabra, verificando desbloqueios e itens; não existe salvamento na bancada, portanto não há equivalência para comparar ainda.

