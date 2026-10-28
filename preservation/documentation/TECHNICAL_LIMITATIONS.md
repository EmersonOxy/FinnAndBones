# Limitações

Sem teste dinâmico nem capturas por solicitação de trabalho em segundo plano. O ZIP veio de API pública identificada por UUID, mas foi comparado com o SHA-256 do catálogo local e a ausência de dependências externas não foi demonstrada. Interface do launcher, conteúdo da tela inicial e funcionamento offline não estão validados. FFDec é descompilador: P-code e comportamento real são necessários para confirmar interpretação. Dados estruturados são transcrição de tabelas, não modelo validado. Exportação dos demais SWFs, sprites e frames, mapeamento de símbolos e revisão completa das classes continuam pendentes; acompanhar logs. Conteúdo proprietário é mantido localmente e não deve ser publicado.

Atualização: hash do pacote foi posteriormente confirmado pelo campo sha256 do catálogo local do Flashpoint. O Flash Player foi iniciado pelo CLIFp, mas a captura de janela retornou timeout; conteúdo da tela e jogabilidade permanecem não observados.


O launcher aberto simultaneamente ao CLIFp registrou erro de parsing de serviços e saída do Game Server com código 1. Não foi demonstrado se houve conflito, e nenhuma causa é afirmada. Investigar serviços, logs e teste sequencial. Interface de captura falhou com timeout e clique por acessibilidade informou geometria indisponível.

Lotes principais e sprites/botões dos 17 SWFs terminaram com OK. Ainda faltam revisão semântica completa dos recursos e confirmação dinâmica.


Diagnóstico de 28/10/2026: log das 08:47:30 registra bind na porta 22500 já ocupada; a segunda instância do Game Server terminou com código 1. O assistente havia iniciado launcher e CLIFp simultaneamente. A relação com o fechamento relatado pelo usuário é hipótese, não confirmada. Às 08:58 o launcher foi reiniciado após desligamento limpo; um único Game Server passou a escutar nas portas 22500 e 22501. Persistiu aviso de parsing server[3].aliases, sem evidência de que causou o fechamento. A captura de janela continuou indisponível; falta testar a primeira missão.
