extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_ui()

func get_mood(value: int) -> String:
	if value == 5:
		return "Great"
	if value == 4:
		return "Good"
	if value == 3:
		return "Normal"
	if value == 2:
		return "Bad"
	if value == 1:
		return "Awful"
	else:
		return "Normal"

func update_player_ui() -> void:
	var player = PlayerManager.player_data

	# =========================
	# Player Information
	# =========================
	#$CanvasLayer/Control/TextureRect/PlayerInfoBox/Panel/PlayerName.text = player.player_name
#
	#$CanvasLayer/Control/TextureRect/PlayerInfoBox/Panel/PlayerInfo.text = (
		#"Lv. %d\nEXP: %d"
		#% [player.level, player.experience]
	#)
	#
	# Player Stats-------------

	# =========================
	# Strength
	# =========================
	var strength_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer/StrengthBox/Panel

	strength_panel.get_node("Label3").text = str(player.strength)
	StatRankHelper.set_rank(strength_panel.get_node("Label"), player.strength)

	# =========================
	# Stamina
	# =========================
	var stamina_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer/StaminaBox/Panel

	stamina_panel.get_node("Label3").text = str(player.stamina)
	StatRankHelper.set_rank(stamina_panel.get_node("Label"), player.stamina)

	# =========================
	# Dexterity
	# =========================
	var dexterity_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer/DexterityBox/Panel

	dexterity_panel.get_node("Label3").text = str(player.dexterity)
	StatRankHelper.set_rank(dexterity_panel.get_node("Label"), player.dexterity)

		
	# =========================
	# Magic
	# =========================
	var magic_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer2/MagicBox/Panel

	magic_panel.get_node("Label3").text = str(player.magic)
	StatRankHelper.set_rank(magic_panel.get_node("Label"), player.magic)

		
	# =========================
	# Wisdom
	# =========================
	var wisdom_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer2/WisdomBox/Panel

	wisdom_panel.get_node("Label3").text = str(player.wisdom)
	StatRankHelper.set_rank(wisdom_panel.get_node("Label"), player.wisdom)

		
	# =========================
	# Charisma
	# =========================
	var charisma_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer2/CharismaBox/Panel

	charisma_panel.get_node("Label3").text = str(player.charisma)
	StatRankHelper.set_rank(charisma_panel.get_node("Label"), player.charisma)

		
	# =========================
	# Stealth
	# =========================
	var stealth_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer3/StealthBox/Panel

	stealth_panel.get_node("Label3").text = str(player.stealth)
	StatRankHelper.set_rank(stealth_panel.get_node("Label"), player.stealth)

		
	# =========================
	# Intelligence
	# =========================
	var intelligence_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer3/IntelligenceBox/Panel

	intelligence_panel.get_node("Label3").text = str(player.intelligence)
	StatRankHelper.set_rank(intelligence_panel.get_node("Label"), player.intelligence)

		
	# =========================
	# Agility
	# =========================
	var agility_panel = $CanvasLayer/Control/ColorRect/StastBox/ColorRect/HBoxContainer/VBoxContainer3/AgilityBox/Panel

	agility_panel.get_node("Label3").text = str(player.agility)
	StatRankHelper.set_rank(agility_panel.get_node("Label"), player.agility)

	# Player Stats ------------
	
	# =========================
	# Player Condition Info
	# =========================
	
	var mood_container = $CanvasLayer/Control/ColorRect/MoodBox/Panel/HBoxContainer
	var money_container = $CanvasLayer/Control/ColorRect/MoneyBox/Panel/HBoxContainer
	money_container.get_node("Label").text = str(player.money)
	mood_container.get_node("Label").text = get_mood(player.mood)
	
	var condition_tree = $CanvasLayer/Control/ColorRect/ConditionBox/Panel/HBoxContainer
	var energy_bar = condition_tree.get_node("EnergyBox/EnergyContainer/ProgressBar")
	var hunger_bar = condition_tree.get_node("HungryBox/HungryContainer/ProgressBar")

	## Update nilai Progress Bar
	energy_bar.max_value = player.max_energy
	energy_bar.value = player.energy
	hunger_bar.max_value = player.max_hungry
	hunger_bar.value = player.hungry
	

@onready var main_action_container = %MainActionContainer
@onready var training_action_container = %TrainingActionContainer

func _on_training_pressed() -> void:
	main_action_container.visible = false;
	training_action_container.visible = true;

func _on_back_to_main_action_button_pressed() -> void:
	training_action_container.visible =false;
	main_action_container.visible = true;

func _on_running_pressed() -> void:
	var result = TrainingManager.train("strength", 1)
	if result.success:
		update_player_ui()
	else:
		pass
