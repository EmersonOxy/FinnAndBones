extends Node
signal language_changed(locale: String)
const PATH = "res://translations/messages.csv"
const PREF = "user://language.cfg"
var languages: PackedStringArray = []
var translations: Array[Translation] = []
var settings_path := PREF

func _ready() -> void:
    load_catalog()
    set_language(load_initial_language(OS.get_locale()), false)

func load_catalog() -> void:
    var f := FileAccess.open(PATH, FileAccess.READ)
    if f == null:
        push_error("Localization catalog unavailable: " + PATH)
        return
    var columns := f.get_csv_line()
    for i in range(1, columns.size()):
        var t := Translation.new()
        t.locale = columns[i]
        languages.append(columns[i])
        translations.append(t)
    while not f.eof_reached():
        var row := f.get_csv_line()
        if row.size() != columns.size() or row[0].is_empty(): continue
        for i in range(1, row.size()):
            translations[i - 1].add_message(row[0], row[i])
    for t in translations: TranslationServer.add_translation(t)

func resolve_system_locale(locale: String) -> String:
    var normalized := locale.replace("-", "_").to_lower()
    for code in languages:
        if code.to_lower() == normalized: return code
    var base := normalized.split("_")[0]
    for code in languages:
        var candidate := code.to_lower()
        if candidate == base or (normalized == base and candidate.begins_with(base + "_")):
            return code
    return "en"

func language_name(locale: String) -> String:
    var key := "LANGUAGE.NAME." + locale
    var result := tr(key)
    return result if result != key else locale

func load_initial_language(system_locale: String) -> String:
    var cfg := ConfigFile.new()
    if cfg.load(settings_path) == OK:
        var saved := str(cfg.get_value("localization", "language", ""))
        if languages.has(saved): return saved
    return resolve_system_locale(system_locale)

func set_language(locale: String, persist: bool = true) -> void:
    if not languages.has(locale): locale = "en"
    TranslationServer.set_locale(locale)
    if persist:
        var cfg := ConfigFile.new()
        cfg.set_value("localization", "language", locale)
        var err := cfg.save(settings_path)
        if err != OK: push_warning("Could not save language preference: %d" % err)
    language_changed.emit(locale)

func item_name(id: String) -> String:
    if id.is_empty(): return tr("INVENTORY.EMPTY")
    var key := "ITEM." + id
    var translated := tr(key)
    return translated if translated != key else id

func enemy_name(id: String) -> String:
    if id.is_empty(): return "—"
    var key := "ENEMY." + id
    var translated := tr(key)
    return translated if translated != key else id
