extends SceneTree
var failures := 0
var checked := 0
func check(ok: bool, what: String) -> void:
    checked += 1
    if ok: print("PASS: " + what)
    else: failures += 1; push_error("FAIL: " + what)
func _initialize() -> void:
    call_deferred("run_tests")
func run_tests() -> void:
    var loc = root.get_node_or_null("Localization")
    check(loc != null, "autoload disponível")
    if loc == null: quit(1); return
    check(loc.resolve_system_locale("pt_BR") == "pt_BR", "detecção português brasileiro")
    check(loc.resolve_system_locale("es_MX") == "es", "detecção espanhol regional")
    check(loc.resolve_system_locale("fr_FR") == "en", "fallback inglês")
    loc.languages.append("fr")
    check(loc.resolve_system_locale("fr_CA") == "fr", "novo idioma pode ser adicionado ao catálogo")
    loc.languages.remove_at(loc.languages.size() - 1)
    var saved_path: String = loc.settings_path
    loc.settings_path = "user://localization_test_only.cfg"
    loc.set_language("es", true)
    check(loc.load_initial_language("pt_BR") == "es", "preferência persiste ao reiniciar")
    var cfg := ConfigFile.new()
    check(cfg.load(loc.settings_path) == OK and cfg.get_value("localization", "language") == "es", "arquivo de preferência separado")
    loc.settings_path = saved_path
    var fixture = load("res://scenes/vertical_slice.tscn").instantiate()
    root.add_child(fixture)
    await process_frame
    check(fixture.game != null, "cena carrega")
    if fixture.game == null: quit(1); return
    fixture.world = "victory"
    fixture.rebuild_ui()
    await process_frame
    var previous_inventory: Array = fixture.game.inventory.duplicate()
    var store = fixture.data
    for language in ["en", "pt_BR", "es"]:
        loc.set_language(language, false)
        await process_frame
        check(TranslationServer.get_locale() == language, "idioma " + language)
        var all_found := true
        for id in store.items:
            if loc.item_name(id) == "ITEM." + id or loc.item_name(id).is_empty(): all_found = false
        check(all_found, "83 itens localizados em " + language)
        var enemies_found := true
        for id in store.enemies:
            if loc.enemy_name(id) == "ENEMY." + id or loc.enemy_name(id).is_empty(): enemies_found = false
        check(enemies_found, "9 personagens localizados em " + language)
        check(fixture.item_cells[0].tooltip_text == loc.item_name("SwordStarter"), "inventário atualizado em " + language)
        check(fixture.game.inventory == previous_inventory, "IDs preservados em " + language)
    var catalog := FileAccess.open("res://translations/messages.csv", FileAccess.READ)
    var columns := catalog.get_csv_line()
    var seen := {}
    var complete := columns == PackedStringArray(["id", "en", "pt_BR", "es"])
    while not catalog.eof_reached():
        var row := catalog.get_csv_line()
        if row.size() == 1 and row[0].is_empty(): continue
        if row.size() != columns.size(): complete = false; continue
        if seen.has(row[0]): complete = false
        seen[row[0]] = true
        for cell in row:
            if cell.strip_edges().is_empty(): complete = false
    check(complete and seen.size() == 176, "176 chaves sem duplicatas ou células vazias")
    loc.set_language("pt_BR", false)
    fixture._select_item(0)
    check(fixture.message.contains("Espada do Finn"), "mensagem de item em português")
    fixture.last_damage = {"evaded": true, "critical": true, "damage": 0}
    fixture._update_damage_text()
    check(fixture.damage_text == "ESQUIVA CRÍTICO", "mensagem de combate em português")
    loc.set_language("es", false)
    await process_frame
    check(fixture.message.contains("Espada de Finn") and fixture.damage_text == "ESQUIVA CRÍTICO", "mensagem dinâmica trocada durante jogo")
    check(loc.item_name("FourLeafClover").contains("é"), "caracteres acentuados")
    check(fixture.game.equip(0, "weapon"), "equipamento antes de alternar idioma")
    loc.set_language("en", false)
    await process_frame
    var gear_name_visible := false
    for node in fixture.find_children("*", "Label", true, false):
        if node.text.contains("Finn's Sword"): gear_name_visible = true
    check(gear_name_visible and fixture.game.gear.weapon == "SwordStarter", "equipamento traduzido com ID preservado")
    fixture.start_level(1)
    var phase_before: String = fixture.game.phase
    loc.set_language("es", false)
    await process_frame
    check(fixture.world == "battle" and fixture.game.phase == phase_before and fixture.game.gear.weapon == "SwordStarter", "troca durante combate preserva estado")
    fixture.set_process(false)
    fixture.attack_from = "finn"
    fixture._on_contact({"evaded": true, "critical": false, "damage": 0})
    loc.set_language("en", false)
    await process_frame
    check(fixture.damage_label.visible and fixture.damage_label.text == "DODGE", "texto de combate visível após trocar idioma")
    loc.set_language("es", false)
    await process_frame
    fixture.game.phase = "victory"
    fixture.world = "victory"
    fixture.game.loot = ["ShieldSimple"]
    fixture.rebuild_ui()
    await process_frame
    var collected := false
    for node in fixture.find_children("*", "Button", true, false):
        if node.text == "Recoger Escudo de madera": collected = true
    check(collected, "nome da recompensa traduzido")
    loc.set_language("en", false)
    await process_frame
    check(fixture.game.loot == ["ShieldSimple"], "troca não altera recompensa")
    fixture.queue_free()
    print("RESULT: %d testes, %d falhas" % [checked, failures])
    quit(1 if failures else 0)
