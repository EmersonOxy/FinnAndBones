extends SceneTree
func _initialize() -> void: call_deferred("test_restart")
func test_restart() -> void:
    var loc = root.get_node("Localization")
    loc.settings_path = "user://localization_restart_test.cfg"
    var args = OS.get_cmdline_user_args()
    if args.size() != 2: push_error("Use write/read e idioma"); quit(1); return
    var phase: String = args[0]
    var expected: String = args[1]
    if phase == "write":
        loc.set_language(expected, true)
        print("PASS: preferência gravada: ", expected)
        quit(0)
    elif phase == "read":
        var language = loc.load_initial_language("fr_FR")
        if language != expected: push_error("Preferência não sobreviveu ao processo"); quit(1); return
        loc.set_language(language, false)
        if TranslationServer.get_locale() != expected: push_error("Inicialização no idioma salvo falhou"); quit(1); return
        print("PASS: novo processo iniciou em ", language)
        quit(0)
    else:
        push_error("Especifique write ou read")
        quit(1)
