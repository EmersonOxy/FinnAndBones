extends SceneTree
const Store = preload("res://scripts/data_store.gd")
const Model = preload("res://scripts/game_model.gd")
const Damage = preload("res://scripts/damage.gd")
const Rewards = preload("res://scripts/rewards.gd")
const Progression = preload("res://scripts/progression.gd")
var failures = 0
func check(ok: bool, description: String) -> void:
    if not ok:
        failures += 1
        push_error("FAIL: " + description)
    else: print("PASS: " + description)
func _initialize() -> void:
    var data = Store.new()
    check(data.load_all(), "tabelas originais e contagens")
    if data.items.is_empty(): quit(1); return
    var game = Model.new(data)
    check(game.inventory.size() == 12 and game.inventory[0] == "SwordStarter", "inventário inicial")
    check(not game.equip(1, "weapon"), "poção não entra em slot de arma")
    var before = game.stats().attack
    check(game.equip(0, "weapon"), "equipar espada")
    check(game.stats().attack == before + int(data.items.SwordStarter["FirstModifier.Value"]), "modificador da espada")
    check(game.unequip("weapon") and game.stats().attack == before, "remover equipamento restaura ataque")
    check(game.find_recipe("FireFlame", "SwordStarter").get("itemResult") == "SwordStarterFire", "receita ordem inversa")
    var craft_model = Model.new(data)
    craft_model.inventory[2] = "FireFlame"
    check(craft_model.craft_verified_example(0, 2) == "SwordStarterFire" and craft_model.inventory[2] == "", "consumo e resultado da receita básica")
    check(craft_model.craft_verified_example(0, 1).begins_with("não implementado"), "combinação genérica permanece não implementada")
    check(game.find_recipe("SwordStarter", "HPPotionSmall").is_empty(), "consulta especial ausente sem declarar inválida")
    var a = {"attack": 15, "defense": 0, "luck": 5, "element": "F", "is_finn": true, "has_weapon": true}
    var b = {"attack": 0, "defense": 5, "luck": 5, "element": "I", "is_finn": false, "has_weapon": false}
    var r = Damage.calculate(a, b, 0.5, 0.5, 0.0)
    check(r.damage == 16 and r.element_multiplier == 1.75, "dano fogo contra gelo")
    a.luck = 30; b.luck = 5
    r = Damage.calculate(a, b, 0.5, 0.0, 0.0)
    check(r.critical and r.damage == 32, "crítico com arma")
    a.luck = 5; b.luck = 30
    r = Damage.calculate(a, b, 0.0, 0.5, 0.5)
    check(r.evaded and r.damage == 0, "evasão")
    game.start_first()
    check(game.enemy_hp == 38 and game.turn == "finn", "primeiro encontro")
    var locked_game = Model.new(data)
    locked_game.equip(0, "weapon")
    locked_game.start_first()
    check(not locked_game.equip(0, "weapon") and not locked_game.unequip("weapon"), "equipamento bloqueado durante combate")
    var rewards = game.choose_loot()
    check(rewards.size() == 3 and rewards.has("MaxHPRing") and rewards.has("ShieldSimple") and rewards.has("LuckPotionSmall"), "primeiro loot sem reposição")
    game.phase = "victory"
    game.loot = ["ShieldSimple"]
    check(game.collect_reward("ShieldSimple") and game.inventory.has("ShieldSimple") and game.loot.is_empty(), "coletar recompensa uma única vez")
    check(not game.collect_reward("ShieldSimple"), "não coletar novamente")
    var pool = [["a", 1.0], ["b", 3.0], ["c", 2.0]]
    check(Rewards.weighted_pop(pool, 0.25) == "b" and pool.size() == 2, "recompensa ponderada sem reposição")
    check(Progression.unlocked([1, 4, 29]).has(5) and Progression.unlocked([1, 4, 29]).has(26) and Progression.unlocked([1, 4, 29]).has(30), "ligações do mapa")
    check(not Progression.unlocked([]).has(2), "nível 2 bloqueado inicialmente")
    print("RESULT: %d falhas" % failures)
    quit(1 if failures > 0 else 0)



