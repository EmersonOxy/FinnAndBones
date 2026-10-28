# Jogabilidade

Observação dinâmica: NÃO REALIZADA, por solicitação de manter trabalho em segundo plano. Combate automático alternado e conclusão por derrota do último inimigo são conclusões estáticas; menu, interação, salvamento, progressão real e screenshots ainda devem ser verificados no player. Não se afirma funcionamento offline antes desse teste.

Teste de infraestrutura: com o Game Server em execução, GETs pelo proxy local 127.0.0.1:22500 para main.swf e items.csv retornaram HTTP 200 e bytes com SHA-256 idêntico aos membros extraídos. Isso demonstra entrega desses dois recursos durante a sessão, não funcionamento do jogo nem independência total da rede.

Validação manual relatada pelo usuário em 28/10/2026: o jogo original funcionou e a primeira missão pôde ser acessada após reiniciar o launcher. Não foi uma bateria sistemática de mecânicas, tempos ou progressão completa.
