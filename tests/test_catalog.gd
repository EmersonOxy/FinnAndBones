extends SceneTree
func _initialize() -> void:
    var f := FileAccess.open("res://translations/messages.csv", FileAccess.READ)
    if f == null: push_error("Catálogo ausente"); quit(1); return
    var headers := f.get_csv_line()
    var seen := {}
    var failures := 0
    var regex := RegEx.new()
    regex.compile("%[sdif]")
    var rows := 0
    while not f.eof_reached():
        var row := f.get_csv_line()
        if row.size() == 1 and row[0].is_empty(): continue
        rows += 1
        if row.size() != headers.size() or row[0].is_empty() or seen.has(row[0]):
            failures += 1; continue
        seen[row[0]] = true
        var expected := []
        for match_result in regex.search_all(row[1]): expected.append(match_result.get_string())
        for col in range(1, row.size()):
            if row[col].strip_edges().is_empty(): failures += 1
            var actual := []
            for match_result in regex.search_all(row[col]): actual.append(match_result.get_string())
            if actual != expected: failures += 1
    print("RESULT: %d entradas, %d idiomas, %d problemas" % [rows, headers.size()-1, failures])
    quit(1 if failures or rows != 176 or headers.size() != 4 else 0)
