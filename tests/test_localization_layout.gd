extends SceneTree
var failures := 0
var checks := 0
func check(ok: bool, message: String):
    checks += 1
    if not ok: failures += 1; push_error("FAIL: " + message)
    else: print("PASS: " + message)
func _initialize(): call_deferred("run_tests")
func run_tests():
    root.size = Vector2i(700, 500)
    var scene = load("res://scenes/vertical_slice.tscn").instantiate()
    root.add_child(scene)
    await process_frame
    var loc = root.get_node("Localization")
    for language in ["en", "pt_BR", "es"]:
        for screen in ["menu", "battle", "settings", "victory"]:
            scene.settings_open = screen == "settings"
            if screen == "battle" or screen == "settings": scene.start_level(1)
            elif screen == "victory":
                scene.world = "victory"
                scene.game.phase = "victory"
                scene.game.loot = ["MaxHPRing", "ShieldSimple", "LuckPotionSmall"]
            else: scene.world = "menu"
            loc.set_language(language, false)
            await process_frame
            await process_frame
            var on_screen := true
            for node in scene.find_children("*", "ScrollContainer", true, false):
                if not node.is_visible_in_tree() or node.get_child_count() == 0: continue
                var rect: Rect2 = node.get_global_rect()
                if rect.position.x < 0 or rect.position.y < 0 or rect.end.x > 701 or rect.end.y > 501:
                    print("OUTSIDE scroll ", language, " ", screen, " ", rect)
                    on_screen = false
            for node in scene.find_children("*", "OptionButton", true, false):
                if not node.is_visible_in_tree(): continue
                var rect: Rect2 = node.get_global_rect()
                if rect.position.x < 0 or rect.end.x > 701 or rect.end.y > 501:
                    print("OUTSIDE select ", language, " ", screen, " ", rect)
                    on_screen = false
            check(on_screen, "áreas e seletor em %s/%s cabem em 700×500" % [language, screen])
    var font := ThemeDB.fallback_font
    var accented := true
    for ch in "ÁáÉéÍíÓóÚúÇçÃãÕõÑñ¿¡":
        if not font.has_char(ch.unicode_at(0)): accented = false
    check(accented, "fonte suporta acentos e pontuação")
    scene.queue_free()
    print("RESULT: %d verificações, %d falhas" % [checks, failures])
    quit(1 if failures else 0)
