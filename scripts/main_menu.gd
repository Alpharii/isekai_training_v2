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
	
	# Player Stats-------------

	# =========================
	# Strength
	# =========================
	var strength_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer/StrengthBox/Panel

	strength_panel.get_node("Label3").text = str(player.strength)
	StatRankHelper.set_rank(strength_panel.get_node("Label"), player.strength)

	# =========================
	# Stamina
	# =========================
	var stamina_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer/StaminaBox/Panel

	stamina_panel.get_node("Label3").text = str(player.stamina)
	StatRankHelper.set_rank(stamina_panel.get_node("Label"), player.stamina)

	# =========================
	# Dexterity
	# =========================
	var dexterity_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer/DexterityBox/Panel

	dexterity_panel.get_node("Label3").text = str(player.dexterity)
	StatRankHelper.set_rank(dexterity_panel.get_node("Label"), player.dexterity)

		
	# =========================
	# Magic
	# =========================
	var magic_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer2/MagicBox/Panel

	magic_panel.get_node("Label3").text = str(player.magic)
	StatRankHelper.set_rank(magic_panel.get_node("Label"), player.magic)

		
	# =========================
	# Wisdom
	# =========================
	var wisdom_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer2/WisdomBox/Panel

	wisdom_panel.get_node("Label3").text = str(player.wisdom)
	StatRankHelper.set_rank(wisdom_panel.get_node("Label"), player.wisdom)

		
	# =========================
	# Charisma
	# =========================
	var charisma_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer2/CharismaBox/Panel

	charisma_panel.get_node("Label3").text = str(player.charisma)
	StatRankHelper.set_rank(charisma_panel.get_node("Label"), player.charisma)

		
	# =========================
	# Stealth
	# =========================
	var stealth_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer3/StealthBox/Panel

	stealth_panel.get_node("Label3").text = str(player.stealth)
	StatRankHelper.set_rank(stealth_panel.get_node("Label"), player.stealth)

		
	# =========================
	# Intelligence
	# =========================
	var intelligence_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer3/IntelligenceBox/Panel

	intelligence_panel.get_node("Label3").text = str(player.intelligence)
	StatRankHelper.set_rank(intelligence_panel.get_node("Label"), player.intelligence)

		
	# =========================
	# Agility
	# =========================
	var agility_panel = $CanvasLayer/Control/TextureRect/StatsContainerBox/ColorRect/HBoxContainer/VBoxContainer3/AgilityBox/Panel

	agility_panel.get_node("Label3").text = str(player.agility)
	StatRankHelper.set_rank(agility_panel.get_node("Label"), player.agility)

	# Player Stats ------------
	
	# =========================
	# Player Condition Info
	# =========================
	
	var condition_tree = $CanvasLayer/Control/TextureRect/ConditionInfoBox/ColorRect/HBoxContainer
	
	condition_tree.get_node("MoneyPanel/HBoxContainer/Label").text = str(player.money)
	condition_tree.get_node("MoodPanel/HBoxContainer/Label").text = get_mood(player.mood)
	
	var energy_bar = condition_tree.get_node("EnergyPanel/ProgressBar")
	var hunger_bar = condition_tree.get_node("HungerPanel/ProgressBar")
	
	# Update nilai Progress Bar
	energy_bar.max_value = player.max_energy
	energy_bar.value = player.energy
	hunger_bar.max_value = player.max_hungry
	hunger_bar.value = player.hungry

	# Update teks Label (contoh: "50 / 100")
	energy_bar.get_node("HBoxContainer/Label").text = "%d / %d" % [player.energy, player.max_energy]
	
	# Jika hunger_bar juga punya struktur Label yang sama:
	hunger_bar.get_node("HBoxContainer/Label").text = "%d / %d" % [player.hungry, player.max_hungry]
	
	# =========================
	# Game Time Info
	# =========================
	
	var game_time_label = %GameTimeLabel
	game_time_label.text = TimeManager.get_datetime_text()
	
	


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

func _on_next_turn_button_pressed() -> void:
	#PlayerManager.save_game()
	get_tree().change_scene_to_file("res://scenes/training.tscn")


func _on_timeline_ended() -> void:
	print("Timeline selesai!")

	PlayerManager.player_data.last_completed_timeline = "timeline"
	#PlayerManager.save_game()

	update_player_ui()



@onready var load_panel = %LoadPanel
@onready var load_list_container = %LoadListContainer

const SAVE_SLOT_SCENE = preload("res://scenes/components/save_slot.tscn")

var slot_mode: String = "load"

func refresh_save_list() -> void:
	for child in load_list_container.get_children():
		child.queue_free()

	for slot_id in range(1, PlayerManager.MAX_SAVE_SLOTS + 1):
		var slot = SAVE_SLOT_SCENE.instantiate()
		load_list_container.add_child(slot)
		slot.setup(PlayerManager.read_save(slot_id), slot_id, slot_mode)
		slot.save_requested.connect(_on_save_slot_pressed)

func _on_save_button_pressed() -> void:
	slot_mode = "save"
	load_panel.visible = true
	refresh_save_list()

func _on_save_slot_pressed(slot_id: int) -> void:
	if not PlayerManager.save_game(slot_id):
		push_warning("Failed to save slot %d." % slot_id)
		return
	refresh_save_list()
	load_panel.visible = false

func _on_cancel_load_button_pressed() -> void:
	load_panel.visible = false

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
