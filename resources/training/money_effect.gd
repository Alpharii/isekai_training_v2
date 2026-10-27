extends TrainingEffect
class_name MoneyEffect

@export var amount: int = -20

func apply(player: Resource, _context: Dictionary) -> Dictionary:
	player.money = player.money + amount
	return {"money_change": amount}
