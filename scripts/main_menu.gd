extends Node2D


func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	update_player_ui()


func update_player_ui() -> void:
	var player = PlayerManager.player_data

	# =========================
	# Player Information
	# =========================
	$CanvasLayer/Control/TextureRect/PlayerInfoBox/Panel/PlayerName.text = player.player_name

	$CanvasLayer/Control/TextureRect/PlayerInfoBox/Panel/PlayerInfo.text = (
		"Lv. %d\nEXP: %d"
		% [player.level, player.experience]
	)

	# =========================
	# Strength
	# =========================
	var strength_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer/StrengthBox/Panel

	strength_panel.get_node("Label3").text = str(player.strength)
	strength_panel.get_node("Label").text = get_stat_rank(player.strength)

	# =========================
	# Stamina
	# =========================
	var stamina_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer/StaminaBox/Panel

	stamina_panel.get_node("Label3").text = str(player.stamina)
	stamina_panel.get_node("Label").text = get_stat_rank(player.stamina)
	
	# =========================
	# Dexterity
	# =========================
	var dexterity_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer/DexterityBox/Panel

	dexterity_panel.get_node("Label3").text = str(player.dexterity)
	dexterity_panel.get_node("Label").text = get_stat_rank(player.dexterity)

		
	# =========================
	# Magic
	# =========================
	var magic_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer2/MagicBox/Panel

	magic_panel.get_node("Label3").text = str(player.magic)
	magic_panel.get_node("Label").text = get_stat_rank(player.magic)

		
	# =========================
	# Wisdom
	# =========================
	var wisdom_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer2/WisdomBox/Panel

	wisdom_panel.get_node("Label3").text = str(player.wisdom)
	wisdom_panel.get_node("Label").text = get_stat_rank(player.wisdom)

		
	# =========================
	# Charisma
	# =========================
	var charisma_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer2/CharismaBox/Panel

	charisma_panel.get_node("Label3").text = str(player.charisma)
	charisma_panel.get_node("Label").text = get_stat_rank(player.charisma)

		
	# =========================
	# Stealth
	# =========================
	var stealth_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer3/StealthBox/Panel

	stealth_panel.get_node("Label3").text = str(player.stealth)
	stealth_panel.get_node("Label").text = get_stat_rank(player.stealth)

		
	# =========================
	# intelligence
	# =========================
	var intelligence_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer3/IntelligenceBox/Panel

	intelligence_panel.get_node("Label3").text = str(player.intelligence)
	intelligence_panel.get_node("Label").text = get_stat_rank(player.intelligence)

		
	# =========================
	# agility
	# =========================
	var agility_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer3/AgilityBox/Panel

	agility_panel.get_node("Label3").text = str(player.agility)
	agility_panel.get_node("Label").text = get_stat_rank(player.agility)
	

func get_stat_rank(value: int) -> String:
	if value >= 1150:
		return "SS+"
	elif value >= 1100:
		return "SS"
	elif value >= 1050:
		return "S+"
	elif value >= 1000:
		return "S"
	elif value >= 950:
		return "A+"
	elif value >= 900:
		return "A"
	elif value >= 850:
		return "B+"
	elif value >= 800:
		return "B"
	elif value >= 700:
		return "C+"
	elif value >= 600:
		return "C"
	elif value >= 500:
		return "D+"
	elif value >= 400:
		return "D"
	elif value >= 300:
		return "E+"
	elif value >= 200:
		return "E"
	elif value >= 100:
		return "F+"
	else:
		return "F"


func _on_next_turn_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/training.tscn")


func _on_timeline_ended() -> void:
	print("Timeline selesai!")

	PlayerManager.player_data.last_completed_timeline = "timeline"
	PlayerManager.save_game()

	update_player_ui()
