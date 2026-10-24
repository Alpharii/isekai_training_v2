extends Node

signal training_completed(result: Dictionary)

const TRAININGS: Array[TrainingData] = [
	preload("res://resources/training/data/speed.tres"),
	preload("res://resources/training/data/rest.tres"),
	#preload("res://resources/training/data/speed.tres"),
]

var trainings: Dictionary[StringName, TrainingData] = {}

func _ready() -> void:
	for training in TRAININGS:
		if training == null:
			continue
		if trainings.has(training.id):
			push_warning("Duplicate training ID: " + str(training.id))
			continue
		trainings[training.id] = training

func train(training_id: StringName) -> Dictionary:
	var player = PlayerManager.player_data
	var training = trainings.get(training_id)
	if training == null:
		return {"success": false, "text": "Error" ,"subtext": "Training tidak dikenal!"}
	if player.energy < training.energy_cost:
		return {"success": false, "text": "Kamu Kelelahan", "subtext": "Energy tidak cukup!"}
	if player.hungry < training.hunger_cost:
		return {"success": false, "text": "Kamu Kelaparan", "subtext": "Kamu butuh makan!"}

	var mood_multiplier := 1.0
	if training.mood_multiplier_enabled:
		match player.mood:
			5: mood_multiplier = 1.3
			4: mood_multiplier = 1.15
			2: mood_multiplier = 0.8
			1: mood_multiplier = 0.6

	player.energy -= training.energy_cost
	var context := {"mood_multiplier": mood_multiplier}
	var effects: Array[Dictionary] = []
	for effect in training.effects:
		if effect != null:
			effects.append(effect.apply(player, context))

	var result := {
		"success": true,
		"training_id": training.id,
		"effects": effects,
		"message": "%s selesai!" % training.display_name
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
