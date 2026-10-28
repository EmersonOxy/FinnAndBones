extends RefCounted
# DamageCalculator.as: draws supplied explicitly to keep tests deterministic.
static func calculate(att: Dictionary, defender: Dictionary, evade_roll: float, crit_roll: float, variation_roll: float) -> Dictionary:
    var al = float(att.luck)
    var dl = float(defender.luck)
    var evade = 0.0
    if al < dl: evade = maxf(0.1, minf(0.2, 0.3 * (1.0 - al / dl)))
    var evaded = evade_roll < evade
    var critical = false
    if att.is_finn and att.has_weapon and al > dl:
        critical = crit_roll < maxf(0.1, minf(0.2, 0.2 * (1.0 - dl / al)))
    var a_element = str(att.element)
    var d_element = str(defender.element)
    var modifier = 1.0
    if a_element != "N" and d_element != "N":
        modifier = 0.7 if a_element == d_element else 1.75
    var raw = (int(att.attack) - int(defender.defense)) * modifier * 0.9
    raw += raw * 0.2 * variation_roll
    var damage = maxi(1, int(floor(raw + 0.5)))
    if evaded: damage = 0
    elif critical: damage *= 2
    return {"damage": damage, "evaded": evaded, "critical": critical, "element_multiplier": modifier}
