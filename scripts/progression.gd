extends RefCounted
# Map.as: standard links and explicit branches. Legendary availability is not modeled.
static func neighbors(level: int) -> Array:
    var result: Array = []
    if level >= 1 and level < 25: result.append(level + 1)
    var extra = {4: [26], 26: [6], 15: [27], 27: [16], 19: [28], 28: [20], 23: [29], 29: [30], 30: [24]}
    result.append_array(extra.get(level, []))
    return result
static func unlocked(cleared: Array) -> Array:
    var result: Array = [1]
    for level in cleared:
        for n in neighbors(int(level)):
            if not result.has(n): result.append(n)
    return result
