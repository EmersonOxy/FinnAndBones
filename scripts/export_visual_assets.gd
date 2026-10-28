extends SceneTree

const ROOT := "C:/Projetos/FinnAndBonesPreservation/"
const SPRITES := ROOT + "assets/sprites/"

func _initialize() -> void:
	_export_clean_finn("finn/sprites/DefineSprite_243_assets.FinnHand", "finn_hand_base", 1, 180)
	_export_clean_finn("finn/sprites/DefineSprite_500_assets.FinnSword", "finn_sword_base", 1, 169)
	_export_clean_finn("finn/sprites/DefineSprite_500_assets.FinnSword", "finn_sword_base", 252, 410)
	_export_item_icons()
	_export_ui_slot("screens/sprites/DefineSprite_62_screens_fla.inventory_slot_container_111/1.svg", "inventory_slot")
	_export_ui_slot("screens/sprites/DefineSprite_533_screens_fla.weapon_slot_192/1.svg", "weapon_slot")
	_export_ui_slot("screens/sprites/DefineSprite_536_screens_fla.shield_weapon_slot_194/1.svg", "shield_slot")
	print("Export visual assets concluído em private/ (ignorado pelo Git).")
	quit()

func _export_clean_finn(source: String, destination: String, first: int, last: int) -> void:
	var folder := "res://private/frames/" + destination
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(folder))
	for frame in range(first, last + 1):
		var svg := FileAccess.get_file_as_string(SPRITES + source + "/" + str(frame) + ".svg")
		if svg.is_empty():
			continue
		var defs_at := svg.find("<defs>")
		if defs_at < 0:
			continue
		var head := ""
		for line in svg.substr(0, defs_at).split("\n"):
			if 'id="sword"' in line or 'id="shield"' in line:
				continue
			head += line + "\n"
		var clean_svg := head + svg.substr(defs_at)
		var image := Image.new()
		if image.load_svg_from_buffer(clean_svg.to_utf8_buffer(), 0.35) == OK:
			image.save_png(ProjectSettings.globalize_path(folder + "/" + str(frame) + ".png"))

func _export_item_icons() -> void:
	var file := FileAccess.open(ROOT + "analysis/items.json", FileAccess.READ)
	if file == null:
		push_error("Não encontrei analysis/items.json")
		return
	var parsed: Dictionary = JSON.parse_string(file.get_as_text())
	var item_dirs := DirAccess.open(SPRITES + "items/sprites")
	if item_dirs == null:
		push_error("Não encontrei os sprites de itens")
		return
	var directories := item_dirs.get_directories()
	var out := "res://private/gear"
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(out))
	for row in parsed.get("rows", []):
		var movie_clip := str(row.get("MovieClip", ""))
		if movie_clip.is_empty() or movie_clip == "null":
			continue
		var source_dir := ""
		for directory in directories:
			if directory.ends_with("_assets." + movie_clip):
				source_dir = directory
				break
		if source_dir.is_empty():
			continue
		var source := SPRITES + "items/sprites/" + source_dir + "/1.svg"
		var image := Image.new()
		if image.load_svg_from_buffer(FileAccess.get_file_as_bytes(source), 1.0) == OK:
			var filename := movie_clip.replace(".", "_") + ".png"
			image.save_png(ProjectSettings.globalize_path(out + "/" + filename))

func _export_ui_slot(source: String, name: String) -> void:
	var image := Image.new()
	if image.load_svg_from_buffer(FileAccess.get_file_as_bytes(SPRITES + source), 1.0) != OK:
		push_warning("Não foi possível exportar o slot " + name)
		return
	var out := "res://private/ui"
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(out))
	image.save_png(ProjectSettings.globalize_path(out + "/" + name + ".png"))
