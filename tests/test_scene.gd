extends SceneTree
func _initialize() -> void:
    call_deferred("run_check")
func run_check() -> void:
    var scene = load("res://scenes/demo.tscn").instantiate()
    root.add_child(scene)
    await process_frame
    if scene.model == null or scene.model.phase != "menu":
        push_error("Inicialização do modelo falhou")
        quit(1)
        return
    scene.model.start_first()
    scene.show_game()
    await process_frame
    var first = scene.model.attack_once()
    if first.get("attacker") != "finn" or scene.model.turn != "enemy":
        push_error("Primeiro ataque e alternância falharam")
        quit(1)
        return
    var second = scene.model.attack_once()
    if second.get("attacker") != "enemy":
        push_error("Ataque do inimigo falhou")
        quit(1)
        return
    scene.show_recipe()
    await process_frame
    print("PASS: cena, dados, primeiro encontro, alternância e tela de consulta")
    scene.queue_free()
    quit(0)
