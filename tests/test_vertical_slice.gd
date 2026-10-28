extends SceneTree

func _initialize() -> void:
    call_deferred("run_check")

func run_check() -> void:
    var scene = load("res://scenes/vertical_slice.tscn").instantiate()
    root.add_child(scene)
    await process_frame
    if scene.game == null:
        push_error("A cena vertical não carregou os dados")
        quit(1)
        return

    scene.start_level(2)
    if scene.encounter_ids != ["enemy1_normal", "enemy1_normal"]:
        push_error("A fase 2 não carregou seus dois encontros dos dados")
        quit(1)
        return

    # One-point HP makes each transition deterministic without replacing the
    # animation-driven combat flow.
    scene.game.enemy.BaseHP = 1
    scene.game.enemy_hp = 1
    scene.timeline.step(10.0)
    if scene.enemy_number != 2 or scene.game.phase != "fight" or scene.world != "battle":
        push_error("A primeira vitória não avançou ao segundo encontro")
        quit(1)
        return

    scene.game.enemy_hp = 1
    scene.timeline.step(10.0)
    if scene.enemy_number != 2 or scene.world != "victory" or scene.game.phase != "victory":
        push_error("O segundo encontro não encerrou a fase")
        quit(1)
        return

    print("PASS: fase 2 inicia automaticamente, transiciona entre os encontros e só então declara vitória")
    scene.queue_free()
    quit(0)
