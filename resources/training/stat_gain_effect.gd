extends TrainingEffect
class_name StatGainEffect

@export_enum(
	"strength", 
	"stamina", 
	"dexterity", 
	"magic", 
	"wisdom", 
	"charisma", 
	"stealth", 
	"intelligence", 
	"agility"
) var stat_name: String = "agility"

@export var min_gain: int = 5
@export var max_gain: int = 10
@export var use_mood_bonus: bool = true

func apply(player: Resource, context: Dictionary) -> Dictionary:
	var gain := randi_range(min_gain, max_gain)
	if use_mood_bonus:
		gain = roundi(gain * context.get("mood_multiplier", 1.0))
	player.set(stat_name, player.get(stat_name) + gain)
	return {"stat": stat_name, "gain": gain}
