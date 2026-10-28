extends Control
const Store = preload("res://scripts/data_store.gd")
const Model = preload("res://scripts/game_model.gd")
var store
var model
var layout: VBoxContainer
var status: Label
var equip_slot: OptionButton
var selected_item: OptionButton
var message := "Laboratório: leia as limitações antes de comparar."

func _ready() -> void:
    store = Store.new()
    if not store.load_all():
        var err = Label.new()
        err.text = "Dados locais não encontrados ou incompletos. Consulte README.md."
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
    reset_ui()
    label("FINN & BONES — LABORATÓRIO", 23)
    label("Protótipo funcional de regras; visuais temporários e ritmo de combate por etapas.")
    button("Iniciar primeira missão", func(): model.start_first(); show_game())
    button("Inventário e equipamento", show_game)
    label("Os dados do jogo permanecem no acervo local. Sem salvamento nesta versão.")

func show_game() -> void:
    reset_ui()
    label("FINN & BONES  |  PROTÓTIPO (700 × 500)", 18)
    var st = model.stats()
    label("Finn: %d/%d HP   ATQ %d  DEF %d  SORTE %d" % [model.hp, model.max_hp, st.attack, st.defense, st.luck])
    label("Inimigo: %s   HP %d   |   Estado: %s   Vez: %s" % [model.enemy.get("Character", "—"), model.enemy_hp, model.phase, model.turn])
    label(message)
    if model.phase == "fight":
        button("Avançar um ataque (temporização ainda não validada)", func():
            var r = model.attack_once()
            message = "%s causou %d de dano%s%s" % [r.attacker, r.damage, " (evasão)" if r.evaded else "", " (crítico)" if r.critical else ""]
            show_game()
        )
    elif model.phase == "victory":
        label("Vitória — recompensas da primeira conclusão: " + str(model.loot))
        if not model.loot.is_empty():
            button("Coletar primeira recompensa", func():
                var id: String = model.loot[0]
                message = "Coletado: " + id if model.collect_reward(id) else "Inventário cheio."
                show_game()
            )
    elif model.phase == "defeat": label("Derrota")
    label("Equipamentos: " + str(model.gear), 13)
    var row = HBoxContainer.new()
    layout.add_child(row)
    selected_item = OptionButton.new()
    selected_item.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    for i in range(12): selected_item.add_item("%02d: %s" % [i + 1, model.inventory[i] if model.inventory[i] != "" else "—"])
    row.add_child(selected_item)
    equip_slot = OptionButton.new()
    for s in ["weapon", "shield", "equipment_1", "equipment_2"]: equip_slot.add_item(s)
    row.add_child(equip_slot)
    var equip_button = Button.new()
    equip_button.text = "Equipar / trocar"
    equip_button.pressed.connect(func():
        var slot = equip_slot.get_item_text(equip_slot.selected)
        message = "Equipado." if model.equip(selected_item.selected, slot) else "Slot vazio ou categoria incompatível."
        show_game()
    )
    row.add_child(equip_button)
    button("Remover equipamento selecionado", func():
        var slot = equip_slot.get_item_text(equip_slot.selected)
        message = "Removido." if model.unequip(slot) else "Slot vazio ou inventário cheio."
        show_game()
    )
    button("Consultar receita especial", show_recipe)
    button("Voltar ao início", show_menu)

func show_recipe() -> void:
    reset_ui()
    label("Consulta de receitas (sem consumir itens)", 20)
    label("Combinação de itens e a regra genérica ainda não estão implementadas.")
    var a = LineEdit.new()
    var b = LineEdit.new()
    a.placeholder_text = "Primeiro ID, por exemplo SwordStarter"
    b.placeholder_text = "Segundo ID, por exemplo FireFlame"
    layout.add_child(a)
    layout.add_child(b)
    var out = Label.new()
    button("Consultar", func():
        var recipe = model.find_recipe(a.text.strip_edges(), b.text.strip_edges())
        out.text = "Receita especial: " + str(recipe.get("itemResult", "não encontrada; combinação genérica não verificada"))
    )
    layout.add_child(out)
    button("Voltar", show_game)

