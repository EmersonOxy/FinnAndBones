extends RefCounted
const Damage = preload("res://scripts/damage.gd")
const Rewards = preload("res://scripts/rewards.gd")
var inventory: Array = []
var gear := {"weapon": "", "shield": "", "equipment_1": "", "equipment_2": ""}
var data
var cleared: Array = []
var hp: int = 50
var max_hp: int = 50
var enemy_hp: int = 0
var enemy: Dictionary = {}
var phase := "menu"
var turn := "finn"
var rng := RandomNumberGenerator.new()
var loot: Array = []
func _init(store):
    data = store
    inventory.resize(12)
    inventory.fill("")
    inventory[0] = "SwordStarter"
    inventory[1] = "HPPotionSmall"
    rng.randomize()
func equip(index: int, slot: String) -> bool:
    if phase == "fight": return false
    if index < 0 or index >= 12 or not gear.has(slot): return false
    var id: String = inventory[index]
    if id == "" or not data.items.has(id): return false
    var category: String = data.items[id].Category
    var required = "W" if slot == "weapon" else ("S" if slot == "shield" else "E")
    if category != required: return false
    var old = gear[slot]
    gear[slot] = id
    inventory[index] = old
    return true
func unequip(slot: String) -> bool:
    if phase == "fight": return false
    if not gear.has(slot) or gear[slot] == "": return false
    var index = inventory.find("")
    if index < 0: return false
    inventory[index] = gear[slot]
    gear[slot] = ""
    return true

# Only the plain base-item recipe where output matches the original strategy is enabled.
func craft_verified_example(i: int, j: int) -> String:
    if i == j or i < 0 or j < 0 or i >= 12 or j >= 12: return "slots inválidos"
    var a: String = inventory[i]
    var b: String = inventory[j]
    if a == "" or b == "": return "faltam ingredientes"
    if a != "SwordStarter" or b != "FireFlame": return "não implementado: regras genéricas e variantes"
    var recipe = find_recipe(a, b)
    if recipe.get("itemResult", "") != "SwordStarterFire": return "dados inconsistentes"
    inventory[i] = "SwordStarterFire"
    inventory[j] = ""
    return "SwordStarterFire"
func stats() -> Dictionary:
    var result = {"attack": 5, "defense": 2, "luck": 5, "element": "N", "is_finn": true, "has_weapon": gear.weapon != ""}
    for id in gear.values():
        if id == "": continue
        var row: Dictionary = data.items[id]
        for prefix in ["FirstModifier", "SecondModifier"]:
            var c = row[prefix + ".Category"]
            var v = int(row[prefix + ".Value"])
            if c == "A": result.attack += v
            elif c == "D": result.defense += v
            elif c == "L": result.luck += v
    return result
func start_encounter(enemy_id: String, restore_hp: bool = true) -> bool:
    if not data.enemies.has(enemy_id):
        return false
    enemy = data.enemies[enemy_id].duplicate()
    enemy_hp = int(enemy.BaseHP)
    if restore_hp:
        hp = max_hp
    phase = "fight"
    turn = "finn"
    loot.clear()

    return true

func start_first() -> void:
    start_encounter("enemy1_normal")
# Original Fight computes damage before starting the attack animation;
# HitAnimation applies it at the hit label.
func prepare_attack() -> Dictionary:
    if phase != "fight": return {}
    var f = stats()
    var e = {"attack": int(enemy.BaseAttack), "defense": int(enemy.BaseDefense), "luck": int(enemy.BaseLuck), "element": _element(str(enemy.Element)), "is_finn": false, "has_weapon": false}
    var attack = f if turn == "finn" else e
    var defense = e if turn == "finn" else f
    if turn == "finn" and gear.weapon != "": attack.element = _element(data.items[gear.weapon].Element)
    if turn == "enemy" and gear.shield != "": defense.element = _element(data.items[gear.shield].Element)
    var evade_roll = rng.randf()
    # The AS3 only calls the critical RNG for Finn with a weapon.
    var crit_roll = rng.randf() if turn == "finn" and gear.weapon != "" else 1.0
    var result = Damage.calculate(attack, defense, evade_roll, crit_roll, rng.randf())
    result["attacker"] = turn
    return result

func apply_attack(result: Dictionary) -> void:
    if result.is_empty() or phase != "fight" or result.attacker != turn: return
    if turn == "finn":
        enemy_hp = maxi(0, enemy_hp - result.damage)
        if enemy_hp == 0:
            phase = "victory"
            loot = choose_loot()
        else: turn = "enemy"
    else:
        hp = maxi(0, hp - result.damage)
        if hp == 0: phase = "defeat"
        else: turn = "finn"

func attack_once() -> Dictionary:
    var result = prepare_attack()
    apply_attack(result)
    return result
func _element(value: String) -> String:
    return value if value == "F" or value == "I" else "N"
func choose_loot() -> Array:
    var pool: Array = []
    var row: Dictionary = data.first_loot.get("1", {}) if not cleared.has(1) else {}
    for i in range(1, 11):
        var token: String = row.get("lootDrop" + str(i), "null:0")
        var parts = token.split(":")
        if parts[0] == "null": break
        pool.append([parts[0], float(parts[1])])
    var selected: Array = []
    while selected.size() < 3 and not pool.is_empty():
        selected.append(Rewards.weighted_pop(pool, rng.randf()))
    # Regular table fallback is deliberately unimplemented until the UI supports it.
    return selected
func collect_reward(id: String) -> bool:
    if phase != "victory" or not loot.has(id): return false
    var index = inventory.find("")
    if index < 0: return false
    inventory[index] = id
    loot.erase(id)
    return true
func find_recipe(a: String, b: String) -> Dictionary:
    for row in data.recipes:
        if (row.item1 == a and row.item2 == b) or (row.item1 == b and row.item2 == a): return row
    return {}
