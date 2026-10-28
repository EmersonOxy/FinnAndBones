# Combate

CONFIRMADO estaticamente: `main_game/dungeon/Fight.as` inicia com ataque de Finn e alterna com o inimigo após o callback de cada golpe; verifica morte depois de cada ataque e emite vitória ou derrota. Duração real depende de animação/callback e ainda não foi medida.

`DamageCalculator.calculateDamage`: com A=ataque, D=defesa, E=multiplicador elemental, r=Math.random(), configurações 10:10, calcula x=(A-D)*E*0,9; depois x=x*(1+0,2*r); dano=max(1, round(x)); evasão o troca por 0, senão crítico o multiplica por 2. Assim o intervalo de multiplicação antes do arredondamento é [0,9; 1,08), não simplesmente ±10%. Confirmar contra P-code e runtime antes de fixar em testes.

Evasão somente se sorte do atacante < sorte do defensor: max(0,10, min(0,20, 0,3*(1-sorte_atacante/sorte_defensor))). Crítico somente em ataque de Finn com arma e sorte atacante > sorte defensor: max(0,10, min(0,20, 0,2*(1-sorte_defensor/sorte_atacante))). Dois sorteios separados. `config.di`: elementos iguais fogo/fogo ou gelo/gelo 0,7; opostos 1,75; normal 1. Defesa usa elemento do escudo contra elemento inimigo, ataque usa elemento da arma contra inimigo. Nenhuma observação dinâmica foi realizada.
