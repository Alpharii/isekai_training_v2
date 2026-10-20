extends Node2D

@onready var load_panel = %LoadPanel
@onready var load_list_container = %LoadListContainer

func _ready() -> void:
	load_panel.visible = false

func _on_new_game_pressed() -> void:
	PlayerManager.new_game()
	get_tree().change_scene_to_file("res://scenes/loading.tscn")

func _on_load_game_pressed() -> void:
	load_panel.visible = true
	refresh_save_list()

func refresh_save_list() -> void:
	for child in load_list_container.get_children():
		child.queue_free()

	if not PlayerManager.has_save():
		var empty_label = Label.new()
		empty_label.text = "No save data available."
		load_list_container.add_child(empty_label)
		return

	var data = PlayerManager.read_save()
	if data.is_empty():
		var error_label = Label.new()
		error_label.text = "Save data is invalid."
		load_list_container.add_child(error_label)
		return

	var slot = VBoxContainer.new()
	var info = Label.new()
	info.text = "%s - Level %d\nEXP: %d | Money: %d" % [
		data.get("player_name", "Player"),
		data.get("level", 1),
		data.get("experience", 0),
		data.get("money", 0)
	]

	var load_button = Button.new()
	load_button.text = "Load Game"
	load_button.pressed.connect(_on_load_slot_pressed)

	slot.add_child(info)
	slot.add_child(load_button)
	load_list_container.add_child(slot)

func _on_load_slot_pressed() -> void:
	if not PlayerManager.load_game():
		push_warning("Failed to load save data.")
		return

	# Muat save Dialogic jika sistem timeline kamu menggunakannya.
	# Dialogic.Save.load_game(PlayerManager.SAVE_SLOT)
	get_tree().change_scene_to_file("res://scenes/loading.tscn")

func _on_cancel_load_button_pressed() -> void:
	load_panel.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()
