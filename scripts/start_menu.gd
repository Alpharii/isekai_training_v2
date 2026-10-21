extends Node2D

func _ready() -> void:
	load_panel.visible = false

func _on_new_game_pressed() -> void:
	PlayerManager.new_game()
	get_tree().change_scene_to_file("res://scenes/loading.tscn")

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
		slot.load_requested.connect(_on_load_slot_pressed)

func _on_load_game_pressed() -> void:
	slot_mode = "load"
	load_panel.visible = true
	refresh_save_list()

func _on_load_slot_pressed(slot_id: int) -> void:
	if not PlayerManager.load_game(slot_id):
		push_warning("Failed to load slot %d." % slot_id)
		return
	get_tree().change_scene_to_file("res://scenes/loading.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
