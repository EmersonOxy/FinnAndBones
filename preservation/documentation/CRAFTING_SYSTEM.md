# Combinação

`mix.csv` contém 82 linhas preservadas em analysis/crafting_recipes.json. `Recipe.areIngredients` aceita ordem inversa por padrão; verifica IDs removendo prefixo Mix_. `Mixer.canMix` exige dois slots preenchidos, saída vazia e relógio ausente. Ao terminar consome entradas, coloca resultado e salva receita quando mustShow. `MixerClock` soma MixTime dos itens, usa 100 ticks de duration*10 ms: duração nominal igual à soma em segundos.

`MixStrategy` prioriza receita especial; caso contrário cria item customizado baseado no primeiro item. `config.di` define primaryModifier=1, secondaryModifier=0,4 e potionModifier=1; `getNumber` aplica floor e garante magnitude mínima 1 para valor não zero. Valores são limitados por MaxMod, e modificador secundário pelo percentual configurado de 100%. Casos particulares e ordem no tratamento de receitas especiais devem ser conferidos no código antes da implementação.

Validação de referências: todas as 82 receitas apontam para IDs presentes nas 83 linhas de items.csv; detalhes em logs/data-validation.txt. Isso não prova que todas sejam alcançáveis em jogo.
