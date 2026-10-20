extends Node2D

@onready var load_panel = %LoadPanel
@onready var load_list_container = %LoadListContainer
const SAVE_SLOT_SCENE = preload("res://scenes/components/save_slot.tscn")

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
		var label = Label.new()
		label.text = "No save data available."
		load_list_container.add_child(label)
		return

	var data = PlayerManager.read_save()
	if data.is_empty():
		var label = Label.new()
		label.text = "Save data is invalid."
		load_list_container.add_child(label)
		return

	var slot = SAVE_SLOT_SCENE.instantiate()
	load_list_container.add_child(slot)
	slot.setup(data)
	slot.load_requested.connect(_on_load_slot_pressed)


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
