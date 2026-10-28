# Recursos

O ZIP contém 17 SWFs, incluindo screens, backgrounds, finn, boss, inimigos, combat_fx, items, loading, tutorials e PreloaderCN; MP3s individuais estão em original/extracted/.../sounds. `swfs.txt` lista as bibliotecas carregadas. `scripts/export-all.ps1` exporta por SWF imagens, shapes, morphshapes, som, fontes, binários, textos e symbolClass sob assets/other, com logs por arquivo. Sprites e botões foram exportados em lote separado; os frames principais também foram exportados; validação de animações continua pendente. Verifique logs para cobertura e falhas antes de considerar a extração concluída.

Atualização: lote principal terminou com OK para os 17 SWFs; 630 arquivos de ActionScript exportados no total (incluindo 291 de main) e 1.762 arquivos em assets/other na contagem inicial. O lote sprite/button SVG terminou com 17 logs OK e 18.302 arquivos; ver logs por SWF. Os sons MP3 originais permanecem sob original/extracted.

analysis/animation_catalog.json cataloga 340 vínculos character ID ↔ symbolClass de 15 CSVs; isto não identifica automaticamente duração, quadros ou papel de cada símbolo.



Frames principais: 17 imagens, um por SWF, em assets/animations; logs de exportação: 17 OK. Os sprites em assets/sprites incluem quadros de sprites em SVG; não se afirma ainda que foram montados como animações reproduzíveis.
