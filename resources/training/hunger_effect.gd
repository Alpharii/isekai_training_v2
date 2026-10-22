extends TrainingEffect
class_name HungerEffect

@export var amount: int = -10

func apply(player: Resource, _context: Dictionary) -> Dictionary:
	player.hungry = clampi(player.hungry + amount, 0, player.max_hungry)
	return {"hunger_change": amount}
