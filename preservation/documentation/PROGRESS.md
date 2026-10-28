# Progresso em 2026-10-28

Concluído: estrutura inicial, aquisição de GameZIP por UUID, cópia preservada e manifesto SHA-256, tabelas estruturadas, FFDec portátil e exportação de 291 scripts e P-code de main, análise estática inicial de combate, inventário, mixer e progressão. Downloads oficiais do Infinity e ferramentas verificados. Em andamento: extração do Infinity e exportação dos SWFs adicionais (ver logs). Pendente: validar catálogo e execução do jogo, funcionamento offline, combate/inventário no runtime, sprites/frames, análise exaustiva e revisão dos dados. Ver TECHNICAL_LIMITATIONS.md.

Atualização: Infinity extraído; catálogo confirma o UUID, SHA-256 e tamanho do pacote. CLIFp baixou e montou o GameZIP e iniciou Flash Player; duas tentativas de captura expiraram, sem confirmação visual de gameplay. Extração de recursos e sprites em andamento. Log: logs/clifp-play.log.

Interface do launcher abriu e mostrou catálogo com 219.394 entradas. Captura do player e launcher expirou e clique não pôde ser efetuado. O log registra saída do Game Server código 1; investigar antes de afirmar operação completa. Lote de recursos principais dos 17 SWFs finalizado; lote sprites em andamento.

O proxy local respondeu HTTP 200 para main.swf e items.csv com hashes iguais às cópias preservadas; teste limitado, sem prova de execução offline integral.

Validação final desta etapa: 17/17 logs de recursos e 17/17 de sprites/botões terminam em OK; 630 arquivos ActionScript exportados de todos os SWFs, 291 P-code de main, 1.762 recursos diversos e 18.302 arquivos de sprites/botões. Total de arquivos não equivale a classes ou animações únicas. Ainda faltam exportação/validação de frames principais, P-code de SWFs adicionais, revisão completa e testes dinâmicos.

Os dez arquivos JSON em analysis foram validados sintaticamente; isso não verifica completude ou semântica. As 82 receitas usam IDs presentes na tabela de itens. Lotes adicionais de P-code e frames iniciados.

Lotes adicionais concluídos: 17/17 logs P-code OK, 630 arquivos de P-code no total; 17/17 logs de frames principais OK, 17 imagens. Os números não comprovam fidelidade da decompilação nem completude de recursos externos. Ainda faltam revisão aprofundada dos sistemas e testes dinâmicos.

Usuário relatou que o jogo abriu, mas fechou ao entrar na primeira missão. Investigação identificou conflito de porta 22500 causado pela execução simultânea de CLIFp e launcher; relação causal com a queda não foi comprovada. Launcher reiniciado sozinho e Game Server escutando em 22500/22501. Reteste da missão pendente.

Fase 2: usuário confirmou manualmente que o original funciona e a primeira missão funciona após reinício. Testes sistemáticos das mecânicas ainda não foram feitos.
