extends Control
const Store = preload("res://scripts/data_store.gd")
const Model = preload("res://scripts/game_model.gd")
const Timeline = preload("res://scripts/battle_timeline.gd")
var data
var game
var timeline
var level := 1
var enemy_number := 1
var encounter_ids: Array[String] = []
var world := "menu"
var message := "Escolha a espada e equipe antes de iniciar."
var ui: Control
var item_list: OptionButton
var gear_list: OptionButton
var cache := {}
var battlefield: Control
var finn_actor: Control
var finn_base: TextureRect
var weapon_layer: TextureRect
var shield_layer: TextureRect
var enemy_actor: Control
var enemy_sprite: TextureRect
var finn_hp_bar: ProgressBar
var enemy_hp_bar: ProgressBar
var status_label: Label
var item_cells: Array[Button] = []
var selected_item := 0
var attack_from := ""
var damage_text := ""
var reaction := ""
var reaction_elapsed := 0.0
var last_frame := -1
var normal_rng := 0.0

func _ready() -> void:
    data = Store.new()
    if not data.load_all():
        message = "Dados locais indisponíveis. Leia README.md."
        return
    game = Model.new(data)
    timeline = Timeline.new(game)
    timeline.action_started.connect(_on_action_start)
    timeline.contact.connect(_on_contact)
    timeline.action_ended.connect(_on_action_end)
    timeline.fight_ended.connect(_on_fight_end)
    rebuild_ui()
    queue_redraw()

func _process(delta: float) -> void:
    normal_rng += delta
    if world == "battle":
        if reaction != "": reaction_elapsed += delta
        timeline.step(delta)
    var frame = int(normal_rng * 30)
    if frame != last_frame:
        last_frame = frame
        refresh_visuals()

func _on_action_start(attacker: String, _result: Dictionary) -> void:
    attack_from = attacker
    reaction = ""
    damage_text = ""

func _on_contact(result: Dictionary) -> void:
    reaction_elapsed = 0.0
    reaction = "evade" if result.evaded else "hurt"
    if game.phase == "victory" or game.phase == "defeat": reaction = "die"
    damage_text = "ESQUIVA" if result.evaded else str(result.damage)
    if result.critical: damage_text += " CRÍTICO"

func _on_action_end(_attacker: String) -> void:
    reaction = ""
    attack_from = ""

func _on_fight_end(outcome: String) -> void:
    if outcome == "victory" and enemy_number < encounter_ids.size():
        enemy_number += 1
        game.start_encounter(encounter_ids[enemy_number - 1], false)
        message = "Fase %d — encontro %d de %d" % [level, enemy_number, encounter_ids.size()]
        timeline.start()
    else:
        world = "victory" if outcome == "victory" else "defeat"
        message = "Selecione recompensas para o inventário." if outcome == "victory" else "Finn foi derrotado."
        rebuild_ui()
    queue_redraw()

func start_level(number: int) -> void:
    if number < 1 or number > 2:
        message = "Esta versão integra apenas as fases 1 e 2."
        return
    var dungeon: Dictionary = data.dungeons.get(str(number), {})
    encounter_ids.clear()
    for index in range(1, 11):
        var token := str(dungeon.get("enemy%d" % index, "null:0"))
        var fields := token.split(":")
        if fields.is_empty() or fields[0] == "null":
            break
        if not data.enemies.has(fields[0]):
            message = "Inimigo ausente nos dados da fase %d." % number
            return
        encounter_ids.append(fields[0])
    if encounter_ids.is_empty():
        message = "A fase %d não tem encontros disponíveis." % number
        return

    level = number
    enemy_number = 1
    var saved_hp: int = game.hp
    if not game.start_encounter(encounter_ids[0], number == 1):
        message = "Não foi possível iniciar a fase %d." % number
        return
    if number != 1:
        game.hp = saved_hp
    world = "battle"
    message = "Fase %d — encontro %d de %d" % [level, enemy_number, encounter_ids.size()]
    timeline.start()
    rebuild_ui()

func rebuild_ui() -> void:
    if ui != null:
        remove_child(ui)
        ui.queue_free()
    ui = MarginContainer.new()
    ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    ui.add_theme_constant_override("margin_left", 8)
    ui.add_theme_constant_override("margin_right", 8)
    ui.add_theme_constant_override("margin_top", 6)
    ui.add_theme_constant_override("margin_bottom", 6)
    add_child(ui)

    var columns := VBoxContainer.new()
    columns.add_theme_constant_override("separation", 6)
    ui.add_child(columns)
    columns.add_child(_panel_label("FINN & BONES  ·  VERTICAL SLICE", 20))

    var fight_panel := PanelContainer.new()
    fight_panel.visible = world != "menu"
    fight_panel.custom_minimum_size.y = 238
    columns.add_child(fight_panel)
    var fight_column := VBoxContainer.new()
    fight_column.add_theme_constant_override("separation", 2)
    fight_panel.add_child(fight_column)
    var hp_row := HBoxContainer.new()
    fight_column.add_child(hp_row)
    var finn_status := VBoxContainer.new()
    finn_status.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    hp_row.add_child(finn_status)
    finn_status.add_child(_panel_label("FINN  ·  %d / %d HP" % [game.hp, game.max_hp], 13))
    finn_hp_bar = ProgressBar.new()
    finn_hp_bar.max_value = game.max_hp
    finn_hp_bar.value = game.hp
    finn_status.add_child(finn_hp_bar)
    var enemy_status := VBoxContainer.new()
    enemy_status.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    hp_row.add_child(enemy_status)
    enemy_status.add_child(_panel_label("ESQUELETO  ·  %d HP" % game.enemy_hp, 13))
    enemy_hp_bar = ProgressBar.new()
    enemy_hp_bar.max_value = maxf(float(game.enemy.get("BaseHP", 1)), 1.0)
    enemy_hp_bar.value = game.enemy_hp
    enemy_status.add_child(enemy_hp_bar)

    battlefield = Control.new()
    battlefield.custom_minimum_size = Vector2(680, 195)
    battlefield.clip_contents = true
    fight_column.add_child(battlefield)
    var background := TextureRect.new()
    background.texture = _load_texture("res://private/frames/background/1.png")
    background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
    battlefield.add_child(background)

    finn_actor = Control.new()
    finn_actor.position = Vector2(260, 210) - Vector2(347.85, 487.25) * 0.7
    finn_actor.scale = Vector2(2, 2)
    battlefield.add_child(finn_actor)
    finn_base = TextureRect.new()
    finn_base.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    finn_base.stretch_mode = TextureRect.STRETCH_SCALE
    finn_actor.add_child(finn_base)
    weapon_layer = _make_layer(finn_actor)
    shield_layer = _make_layer(finn_actor)
    weapon_layer.position = Vector2(347.85 + 53.6, 487.25 - 39.25) * 0.35
    weapon_layer.rotation = 0.136
    weapon_layer.scale = Vector2(0.46, 0.46)
    shield_layer.position = Vector2(347.85 - 22.8, 487.25 - 38.55) * 0.35
    shield_layer.scale = Vector2(0.46, 0.46)

    enemy_actor = Control.new()
    enemy_actor.position = Vector2(430, 210) - Vector2(56.7, 116.1) * 0.7
    enemy_actor.scale = Vector2(2, 2)
    battlefield.add_child(enemy_actor)
    enemy_sprite = TextureRect.new()
    enemy_sprite.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    enemy_sprite.stretch_mode = TextureRect.STRETCH_SCALE
    enemy_actor.add_child(enemy_sprite)

    var lower := HBoxContainer.new()
    lower.custom_minimum_size.y = 178
    lower.add_theme_constant_override("separation", 6)
    columns.add_child(lower)
    var stats_panel := _new_panel(lower, 150)
    stats_panel.add_child(_panel_label("EQUIPAMENTO", 13))
    stats_panel.add_child(_panel_label("ATQ  %d" % game.stats().attack, 12))
    stats_panel.add_child(_panel_label("DEF  %d" % game.stats().defense, 12))
    stats_panel.add_child(_panel_label("SORTE  %d" % game.stats().luck, 12))
    stats_panel.add_child(_gear_row("Arma", "weapon"))
    stats_panel.add_child(_gear_row("Escudo", "shield"))

    var inventory_panel := _new_panel(lower, 300)
    inventory_panel.add_child(_panel_label("INVENTÁRIO  ·  12 ESPAÇOS", 13))
    var inventory_grid := GridContainer.new()
    inventory_grid.columns = 4
    inventory_grid.add_theme_constant_override("h_separation", 2)
    inventory_grid.add_theme_constant_override("v_separation", 1)
    inventory_panel.add_child(inventory_grid)
    item_cells.clear()
    for index in range(12):
        var cell := Button.new()
        cell.custom_minimum_size = Vector2(48, 43)
        cell.tooltip_text = game.inventory[index] if game.inventory[index] != "" else "Espaço vazio"
        cell.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
        cell.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
        cell.pressed.connect(_select_item.bind(index))
        var slot_frame := TextureRect.new()
        slot_frame.texture = _load_texture("res://private/ui/inventory_slot.png")
        slot_frame.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
        slot_frame.stretch_mode = TextureRect.STRETCH_SCALE
        slot_frame.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
        slot_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
        cell.add_child(slot_frame)
        var icon := TextureRect.new()
        icon.name = "ItemIcon"
        icon.texture = _item_texture(game.inventory[index])
        icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
        icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
        icon.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
        icon.offset_left = 4
        icon.offset_top = 3
        icon.offset_right = -4
        icon.offset_bottom = -3
        icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
        cell.add_child(icon)
        inventory_grid.add_child(cell)
        item_cells.append(cell)

    var actions_panel := _new_panel(lower, 196)
    status_label = _panel_label(message, 12)
    status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    actions_panel.add_child(status_label)
    add_button_to(actions_panel, "Equipar selecionado", func(): _equip_selected())
    add_button_to(actions_panel, "Remover arma", func(): _remove_gear("weapon"))
    add_button_to(actions_panel, "Remover escudo", func(): _remove_gear("shield"))
    if world == "menu":
        add_button_to(actions_panel, "Iniciar fase 1", func(): start_level(1))
    elif world == "victory":
        for reward in game.loot.duplicate():
            var reward_id: String = reward
            add_button_to(actions_panel, "Coletar " + reward_id, func():
                message = "Coletado: " + reward_id if game.collect_reward(reward_id) else "Inventário cheio"
                rebuild_ui()
            )
        if level == 1:
            add_button_to(actions_panel, "Avançar à fase 2", func(): start_level(2))
        else:
            add_button_to(actions_panel, "Voltar ao início", func(): world = "menu"; rebuild_ui())
    elif world == "defeat":
        add_button_to(actions_panel, "Tentar novamente", func(): world = "menu"; rebuild_ui())
    refresh_visuals()

func _make_layer(parent: Control) -> TextureRect:
    var layer := TextureRect.new()
    layer.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    layer.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
    parent.add_child(layer)
    return layer

func _new_panel(parent: Control, width: float) -> VBoxContainer:
    var panel := PanelContainer.new()
    panel.custom_minimum_size.x = width
    panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    parent.add_child(panel)
    var content := VBoxContainer.new()
    content.add_theme_constant_override("separation", 3)
    panel.add_child(content)
    return content

func _panel_label(text: String, size: int) -> Label:
    var label := Label.new()
    label.text = text
    label.add_theme_font_size_override("font_size", size)
    return label

func _gear_row(title: String, slot: String) -> HBoxContainer:
    var row := HBoxContainer.new()
    var slot_frame := TextureRect.new()
    slot_frame.custom_minimum_size = Vector2(32, 32)
    slot_frame.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    slot_frame.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    slot_frame.texture = _load_texture("res://private/ui/weapon_slot.png" if slot == "weapon" else "res://private/ui/shield_slot.png")
    row.add_child(slot_frame)
    var icon := TextureRect.new()
    icon.name = "GearIcon"
    icon.custom_minimum_size = Vector2(28, 28)
    icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    icon.texture = _item_texture(game.gear[slot])
    row.add_child(icon)
    row.add_child(_panel_label(title + ": " + (game.gear[slot] if game.gear[slot] != "" else "—"), 11))
    return row

func add_button_to(parent: Control, title: String, callback: Callable) -> void:
    var button := Button.new()
    button.text = title
    button.custom_minimum_size.y = 25
    button.disabled = world == "battle"
    button.pressed.connect(callback)
    parent.add_child(button)

func _select_item(index: int) -> void:
    selected_item = index
    message = "Selecionado: " + game.inventory[index] if game.inventory[index] != "" else "Espaço vazio"
    rebuild_ui()

func _equip_selected() -> void:
    var id: String = game.inventory[selected_item]
    var category := str(data.items.get(id, {}).get("Category", ""))
    var slot := "weapon" if category == "W" else ("shield" if category == "S" else "")
    message = "Equipado: " + id if slot != "" and game.equip(selected_item, slot) else "Selecione uma arma ou escudo compatível."
    rebuild_ui()

func _remove_gear(slot: String) -> void:
    message = "Equipamento removido." if game.unequip(slot) else "Slot vazio ou inventário cheio."
    rebuild_ui()

func _item_texture(item_id: String) -> Texture2D:
    if item_id.is_empty() or not data.items.has(item_id):
        return null
    var movie_clip := str(data.items[item_id].get("MovieClip", ""))
    if movie_clip.is_empty() or movie_clip == "null":
        return null
    return _load_texture("res://private/gear/" + movie_clip.replace(".", "_") + ".png")

func _load_texture(path: String) -> Texture2D:
    if cache.has(path): return cache[path]
    var loaded := load(path) as Texture2D
    if loaded != null: cache[path] = loaded
    return loaded

func refresh_visuals() -> void:
    if game == null or finn_base == null:
        return
    var weapon_equipped: bool = not game.gear.weapon.is_empty()
    var set_name := "finn_sword_base" if weapon_equipped else "finn_hand_base"
    var frame := 1 + int(normal_rng * 30.0) % 22
    if world == "battle" and attack_from == "finn":
        frame = (346 if game.gear.shield == "" else 252) if timeline.pending.get("critical", false) else 25
        frame += int(timeline.elapsed * 30.0)
    elif world == "battle" and attack_from == "enemy" and reaction != "":
        var start := (94 if weapon_equipped else 103)
        if reaction == "evade": start = 60 if weapon_equipped else 70
        elif reaction == "die": start = 134 if weapon_equipped else 144
        frame = start + int(reaction_elapsed * 30.0)
    elif world == "defeat":
        frame = 169 if weapon_equipped else 180
    var texture_name := "res://private/frames/%s/%d.png" % [set_name, frame]
    finn_base.texture = _load_texture(texture_name)
    finn_base.size = finn_base.texture.get_size() if finn_base.texture != null else Vector2.ZERO
    finn_actor.size = finn_base.size
    weapon_layer.texture = _item_texture(game.gear.weapon)
    shield_layer.texture = _item_texture(game.gear.shield)
    weapon_layer.visible = weapon_layer.texture != null
    shield_layer.visible = shield_layer.texture != null
    if weapon_layer.texture != null: weapon_layer.size = weapon_layer.texture.get_size()
    if shield_layer.texture != null: shield_layer.size = shield_layer.texture.get_size()
    if finn_hp_bar != null:
        finn_hp_bar.max_value = game.max_hp
        finn_hp_bar.value = game.hp
        enemy_hp_bar.max_value = maxf(float(game.enemy.get("BaseHP", 1)), 1.0)
        enemy_hp_bar.value = game.enemy_hp
    if status_label != null: status_label.text = message
    if enemy_sprite != null:
        var enemy_set := "enemy_idle"
        var enemy_frame := 1 + int(normal_rng * 30.0) % 21
        if world == "battle" and attack_from == "enemy":
            enemy_set = "enemy_attack"
            enemy_frame = mini(29, 1 + int(timeline.elapsed * 30.0))
        elif world == "battle" and attack_from == "finn" and reaction != "":
            enemy_set = "enemy_die" if reaction == "die" else "enemy_" + reaction
            enemy_frame = mini(18 if reaction != "evade" else 25, 1 + int(reaction_elapsed * 30.0))
        elif world == "victory":
            enemy_set = "enemy_die"
            enemy_frame = 18
        enemy_sprite.texture = _load_texture("res://private/frames/%s/%d.png" % [enemy_set, enemy_frame])
        enemy_sprite.size = enemy_sprite.texture.get_size() if enemy_sprite.texture != null else Vector2.ZERO
        enemy_actor.size = enemy_sprite.size

func _draw() -> void:
    pass
