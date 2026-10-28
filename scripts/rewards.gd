extends RefCounted
# ProbabilisticSet.as: random selection with removal, optionally deterministic draws.
static func weighted_pop(pool: Array, roll: float) -> Variant:
    if pool.is_empty(): return null
    var total = 0.0
    for entry in pool: total += float(entry[1])
    var value = roll * total
    for i in range(pool.size()):
        if value <= float(pool[i][1]):
            var selected = pool[i][0]
            pool.remove_at(i)
            return selected
        value -= float(pool[i][1])
    return null
