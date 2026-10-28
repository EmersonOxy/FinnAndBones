# Ferramentas e origem

- Infinity 14.0.3 portátil: https://flashpointarchive.org/downloads/ ; arquivo de https://download.unstable.life/archive/infinity/Flashpoint%20Infinity%2014.0.3.7z ; SHA-256 `17f6ab93a7ca1f0adc468649f3d376aa3deb30caa808837a7735e8a6dc0e7502`, igual ao publicado oficialmente. Extração em tools/flashpoint.
- Instalador oficial https://github.com/FlashpointProject/FlashpointComponentTools/releases/latest/download/FlashpointInstaller.exe ; SHA-256 `a77feb80b295e64abf8abec5339d1d838cbea732e1d410fdf246f69ab55c81c2`, igual ao site. Foi iniciado oculto e interrompido; preferiu-se a versão portátil, sem interação visual.
- FFDec 26.4.0 ZIP oficial https://github.com/jindrapetrik/jpexs-decompiler/releases/tag/version26.4.0 ; SHA-256 `56ce960aeafc7caf034e2052ba49f878a883f7c7ca690da6eeffca9587b5e4b9`, igual ao digest da release. CLI validada com Java existente via `java -Djava.awt.headless=true -jar tools/ffdec/ffdec.jar -help`.
- CLIFp 0.9.16, https://github.com/oblivioncth/CLIFp/releases/tag/v0.9.16 ; SHA-256 `a5491d89a0e77237c1540d5e861a388a6f001c039c809086421612cce23d37ee`, igual ao digest da release. Extraído em tools/clifp; ainda não instalado no Flashpoint nem testado com o jogo.

`tar.exe` falhou por codec LZMA não suportado; 7-Zip existente foi usado. Não houve alteração de proteções do Windows.

A extração terminou com código 0 (20.378 arquivos, 4.086.484.926 bytes). CLIFp-C.exe e CLIFp.exe foram copiados à raiz da instalação portátil; ajuda validada e play -i usado. O catálogo local foi consultado por UUID; o player iniciou e CLIFp informou montagem. Interface e execução completa não foram verificadas.

O launcher abriu e exibiu a página inicial e um total de 219.394 entradas na árvore de acessibilidade. A interface de captura de janelas expirou; clique via acessibilidade retornou geometry unavailable. O log do launcher registrou Game Server exited with code 1 depois de aberto enquanto CLIFp estava ativo; causa não determinada. Evitar supor que o servidor permaneceu operacional. Ver Launcher/launcher.log.

Atualização: interface do launcher foi observada via árvore de acessibilidade; página inicial e catálogo carregaram. O servidor do CLIFp respondeu via proxy para dois recursos confirmados; ainda não há teste offline completo.
