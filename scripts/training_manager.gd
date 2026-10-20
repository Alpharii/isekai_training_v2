
extends Node

signal training_completed(result: Dictionary)

func train(stat_name: String, base_gain: int = 5) -> Dictionary:
	var player = PlayerManager.player_data
	if player.energy < 20:
		return {"success": false, "message": "Energy tidak cukup!"}
	if not stat_name in ["strength", "stamina", "dexterity", "magic", "wisdom", "charisma", "stealth", "intelligence", "agility"]:
		return {"success": false, "message": "Training tidak valid!"}

	var mood_bonus := 1.0
	match player.mood:
		5: mood_bonus = 1.3
		4: mood_bonus = 1.15
		2: mood_bonus = 0.8
		1: mood_bonus = 0.6

	var gain := int(round(base_gain * mood_bonus))
	player.set(stat_name, player.get(stat_name) + gain)
	player.energy = max(0, player.energy - 20)
	player.hungry = min(player.max_hungry, player.hungry - 10)

	var result := {
		"success": true,
		"stat": stat_name,
		"gain": gain,
		"message": "%s +%d" % [stat_name.capitalize(), gain]
	}
	training_completed.emit(result)
	return result

func rest() -> void:
	var player = PlayerManager.player_data
	player.energy = min(player.max_energy, player.energy + 15)
	player.hungry = min(player.max_hungry, player.hungry + 5)
	
	if(player.energy > player.max_energy):
		player.energy = player.max_energy
	if(player.hungry > player.max_hungry):
		player.hungry = player.max_hungry

func eat(cost: int = 20) -> bool:
	var player = PlayerManager.player_data
	if player.money < cost:
		return false
	player.money -= cost
	player.hungry = max(0, player.hungry - 30)
	return true
