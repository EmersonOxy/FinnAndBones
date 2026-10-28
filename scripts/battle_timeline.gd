extends RefCounted
# Frame labels from the original SWFs at 30 fps, see analysis/animation_timing.json.
signal action_started(attacker: String, result: Dictionary)
signal contact(result: Dictionary)
signal action_ended(attacker: String)
signal fight_ended(outcome: String)
var model
var state := "stopped"
var elapsed := 0.0
var hit_at := 0.0
var end_at := 0.0
var pending := {}
var attacker := ""
var did_contact := false
func _init(game): model = game
func start() -> void:
	state = "ready"
	elapsed = 0.0
func step(delta: float) -> void:
	var remaining = maxf(0.0, delta)
	while state != "stopped":
		if state == "ready":
			if model.phase != "fight":
				state = "stopped"
				fight_ended.emit(model.phase)
				return
			_begin()
		var next_time = hit_at if not did_contact else end_at
		var dt = minf(remaining, maxf(0.0, next_time - elapsed))
		elapsed += dt
		remaining -= dt
		if elapsed + 0.000001 < next_time: return
		if not did_contact:
			did_contact = true
			model.apply_attack(pending)
			# Durations are label deltas from analysis/animation_timing.json at 30 fps.
			var reaction_frames = 25 if pending.evaded else 18
			if attacker == "enemy":
				var has_weapon: bool = not str(model.gear.get("weapon", "")).is_empty()
				if model.phase == "defeat": reaction_frames = 35 if has_weapon else 36
				elif pending.evaded: reaction_frames = 32 if has_weapon else 30
				else: reaction_frames = 38 if has_weapon else 37
			elif model.phase == "victory":
				reaction_frames = 18
			end_at = maxf(end_at, hit_at + reaction_frames / 30.0)
			contact.emit(pending)
		else:
			action_ended.emit(attacker)
			state = "ready"
			if model.phase != "fight":
				state = "stopped"
				fight_ended.emit(model.phase)
				return
		if remaining <= 0.000001: return
func _begin() -> void:
	pending = model.prepare_attack()
	attacker = str(pending.get("attacker", ""))
	if attacker == "": state = "stopped"; return
	elapsed = 0.0
	did_contact = false
	if attacker == "enemy":
		hit_at = 16.0 / 30.0
		# The clip has 29 frames and stops on frame 29 (frame-script index 28).
		end_at = 28.0 / 30.0
	elif not model.gear.weapon.is_empty():
		if pending.critical:
			if model.gear.shield.is_empty():
				hit_at = 31.0 / 30.0; end_at = 64.0 / 30.0
			else:
				hit_at = 53.0 / 30.0; end_at = 93.0 / 30.0
		else:
			hit_at = 13.0 / 30.0; end_at = 33.0 / 30.0
	else:
		hit_at = 13.0 / 30.0; end_at = 41.0 / 30.0
	state = "animating"
	action_started.emit(attacker,pending)
