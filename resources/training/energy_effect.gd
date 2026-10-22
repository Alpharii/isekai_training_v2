extends TrainingEffect
class_name EnergyEffect

@export var amount: int = -20

func apply(player: Resource, _context: Dictionary) -> Dictionary:
	player.energy = clampi(player.energy + amount, 0, player.max_energy)
	return {"energy_change": amount}
