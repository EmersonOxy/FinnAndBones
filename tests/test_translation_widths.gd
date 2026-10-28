extends SceneTree
var failures := 0
func _initialize(): call_deferred("inspect")
func inspect():
    root.size = Vector2i(700, 500)
    var scene = load("res://scenes/vertical_slice.tscn").instantiate()
    root.add_child(scene)
    await process_frame
    var loc = root.get_node("Localization")
    for language in ["en", "pt_BR", "es"]:
        scene.world = "victory"
        scene.game.phase = "victory"
        scene.game.loot = ["MaxHPRing", "ShieldSimple", "LuckPotionSmall"]
        loc.set_language(language, false)
        await process_frame
        await process_frame
        var reward_button: Button
        for b in scene.find_children("*", "Button", true, false):
            if b.text.begins_with("Collect ") or b.text.begins_with("Coletar ") or b.text.begins_with("Recoger "): reward_button = b; break
        if reward_button == null: push_error("Botão de recompensa não encontrado"); quit(1); return
        var available = reward_button.size.x - reward_button.get_theme_stylebox("normal").get_minimum_size().x
        var font = reward_button.get_theme_font("font")
        var size = reward_button.get_theme_font_size("font_size")
        for id in scene.data.items:
            var text = TranslationServer.translate("REWARD.COLLECT") % loc.item_name(id)
            var width = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, size).x
            if width > available + 1:
                failures += 1
                push_error("Item fora do botão: %s %s" % [language, id])
    print("RESULT: 249 nomes em botões de recompensa, %d excedem a largura" % failures)
    scene.queue_free(); quit(1 if failures else 0)
