extends RefCounted

# As tabelas permanecem fora do projeto e são lidas sem alterar os originais.
const ROOT = "C:/Projetos/FinnAndBonesPreservation/"
var items: Dictionary = {}
var enemies: Dictionary = {}
var recipes: Array = []
var dungeons: Dictionary = {}
var first_loot: Dictionary = {}

func load_all() -> bool:
    for spec in [["items.json", "items"], ["enemies.json", "enemies"], ["crafting_recipes.json", "recipes"], ["progression.json", "dungeons"]]:
        var file = FileAccess.open(ROOT + "analysis/" + spec[0], FileAccess.READ)
        if file == null:
            return false
        var data = JSON.parse_string(file.get_as_text())
        if not data is Dictionary or not data.has("rows"):
            return false
        for row in data.rows:
            match spec[1]:
                "items": items[row.Name] = row
                "enemies": enemies[row.Character] = row
                "recipes": recipes.append(row)
                "dungeons": dungeons[row.Dungeon] = row
    var path = ROOT + "original/extracted/content/i.cartoonnetwork.com/games/adventuretime/finn-and-bones/firstLoot.csv"
    var f = FileAccess.open(path, FileAccess.READ)
    if f == null: return false
    var headers = f.get_csv_line()
    while not f.eof_reached():
        var cells = f.get_csv_line()
        if cells.size() != headers.size(): continue
        var row = {}
        for i in range(headers.size()): row[headers[i]] = cells[i]
        first_loot[row.Dungeon] = row
    return items.size() == 83 and recipes.size() == 82 and enemies.size() == 9 and dungeons.size() == 32
