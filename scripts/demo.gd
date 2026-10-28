extends Control
const Store = preload("res://scripts/data_store.gd")
const Model = preload("res://scripts/game_model.gd")
var store
var model
var layout: VBoxContainer
var status: Label
var equip_slot: OptionButton
var selected_item: OptionButton
var message_key := "DEBUG.DESCRIPTION"
var message_args: Array = []
var message := ""
var current_screen := "menu"

func _ready() -> void:
    Localization.language_changed.connect(_on_language_changed)
    _set_message("DEBUG.DESCRIPTION")
    store = Store.new()
    if not store.load_all():
        var err = Label.new()
        err.text = tr("MESSAGE.MISSING_DATA")
        add_child(err)
        return
    model = Model.new(store)
    show_menu()

func reset_ui() -> void:
    for child in get_children(): child.queue_free()
    layout = VBoxContainer.new()
    layout.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    layout.add_theme_constant_override("separation", 5)
    add_child(layout)

func label(text: String, size: int = 15) -> Label:
    var l = Label.new()
    l.text = text
    l.add_theme_font_size_override("font_size", size)
    l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    layout.add_child(l)
    return l

func button(text: String, action: Callable) -> void:
    var b = Button.new()
    b.text = text
    b.pressed.connect(action)
    layout.add_child(b)

func show_menu() -> void:
    current_screen = "menu"
    reset_ui()
    var selector := OptionButton.new()
    for code in Localization.languages:
        selector.add_item(Localization.language_name(code))
        selector.set_item_metadata(selector.item_count - 1, code)
        if code == TranslationServer.get_locale(): selector.select(selector.item_count - 1)
    selector.item_selected.connect(func(index: int): Localization.set_language(str(selector.get_item_metadata(index))))
    layout.add_child(selector)
    label(tr("DEBUG.TITLE"), 23)
    label(tr("DEBUG.DESCRIPTION"))
    button(tr("DEBUG.START"), func(): model.start_first(); show_game())
    button(tr("DEBUG.INVENTORY"), show_game)
    label(tr("DEBUG.NO_SAVE"))

func show_game() -> void:
    current_screen = "game"
    reset_ui()
    label(tr("DEBUG.PROTOTYPE"), 18)
    var st = model.stats()
    label(tr("DEBUG.STATS") % [model.hp, model.max_hp, st.attack, st.defense, st.luck])
    label(tr("DEBUG.ENEMY") % [Localization.enemy_name(str(model.enemy.get("Character", ""))), model.enemy_hp, tr("STATE." + model.phase), tr("ACTOR." + model.turn)])
    label(message)
    if model.phase == "fight":
        button(tr("DEBUG.ATTACK"), func():
            var r = model.attack_once()
            _set_message("DEBUG.HIT", [r.attacker, r.damage, r.evaded, r.critical])
            show_game()
        )
    elif model.phase == "victory":
        label(tr("DEBUG.VICTORY") % ", ".join(model.loot.map(func(id): return Localization.item_name(str(id)))))
        if not model.loot.is_empty():
            button(tr("DEBUG.COLLECT"), func():
                var id: String = model.loot[0]
                if model.collect_reward(id): _set_message("MESSAGE.COLLECTED", [id])
                else: _set_message("MESSAGE.INVENTORY_FULL")
                show_game()
            )
    elif model.phase == "defeat": label(tr("DEBUG.DEFEAT"))
    label(tr("DEBUG.GEAR") % ", ".join(model.gear.values().map(func(id): return Localization.item_name(str(id)))), 13)
    var row = HBoxContainer.new()
    layout.add_child(row)
    selected_item = OptionButton.new()
    selected_item.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    for i in range(12): selected_item.add_item("%02d: %s" % [i + 1, Localization.item_name(model.inventory[i]) if model.inventory[i] != "" else "—"])
    row.add_child(selected_item)
    equip_slot = OptionButton.new()
    for entry in [["GEAR.WEAPON", "weapon"], ["GEAR.SHIELD", "shield"], ["DEBUG.EQUIP_1", "equipment_1"], ["DEBUG.EQUIP_2", "equipment_2"]]:
        equip_slot.add_item(tr(entry[0]))
        equip_slot.set_item_metadata(equip_slot.item_count - 1, entry[1])
    row.add_child(equip_slot)
    var equip_button = Button.new()
    equip_button.text = tr("DEBUG.EQUIP")
    equip_button.pressed.connect(func():
        var slot = str(equip_slot.get_item_metadata(equip_slot.selected))
        _set_message("DEBUG.EQUIPPED" if model.equip(selected_item.selected, slot) else "DEBUG.EQUIP_INVALID")
        show_game()
    )
    row.add_child(equip_button)
    button(tr("DEBUG.REMOVE"), func():
        var slot = str(equip_slot.get_item_metadata(equip_slot.selected))
        _set_message("DEBUG.REMOVED" if model.unequip(slot) else "MESSAGE.REMOVE_INVALID")
        show_game()
    )
    button(tr("DEBUG.RECIPES"), show_recipe)
    button(tr("MENU.RETURN"), show_menu)

func show_recipe() -> void:
    current_screen = "recipe"
    reset_ui()
    label(tr("DEBUG.RECIPE_TITLE"), 20)
    label(tr("DEBUG.RECIPE_NOTE"))
    var a = LineEdit.new()
    var b = LineEdit.new()
    a.placeholder_text = tr("DEBUG.RECIPE_FIRST")
    b.placeholder_text = tr("DEBUG.RECIPE_SECOND")
    layout.add_child(a)
    layout.add_child(b)
    var out = Label.new()
    button(tr("DEBUG.SEARCH"), func():
        var recipe = model.find_recipe(a.text.strip_edges(), b.text.strip_edges())
        out.text = tr("DEBUG.RECIPE_FOUND") % (Localization.item_name(str(recipe.itemResult)) if not recipe.is_empty() else tr("DEBUG.RECIPE_MISSING"))
    )
    layout.add_child(out)
    button(tr("DEBUG.BACK"), show_game)


func _set_message(key: String, args: Array = []) -> void:
    message_key = key
    message_args = args.duplicate()
    _refresh_message()

func _refresh_message() -> void:
    var args := message_args.duplicate()
    if message_key == "MESSAGE.COLLECTED" and not args.is_empty(): args[0] = Localization.item_name(str(args[0]))
    if message_key == "DEBUG.HIT" and args.size() == 4:
        args = [tr("ACTOR." + str(args[0])), args[1], tr("DEBUG.DODGED") if args[2] else "", tr("DEBUG.CRITICAL") if args[3] else ""]
    message = tr(message_key) if args.is_empty() else tr(message_key) % args

func _on_language_changed(_locale: String) -> void:
    _refresh_message()
    if model == null: return
    match current_screen:
        "menu": show_menu()
        "game": show_game()
        "recipe": show_recipe()
