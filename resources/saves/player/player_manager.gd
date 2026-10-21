
extends Node

var player_data: PlayerData = PlayerData.new()
var is_new_game: bool = true
var current_slot: int = 1

const MAX_SAVE_SLOTS := 10
const SAVE_DIR := "user://saves/"
const SAVE_PREFIX := "slot_"

func _ready() -> void:
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(SAVE_DIR))

func get_save_path(slot_id: int) -> String:
	if slot_id < 1 or slot_id > MAX_SAVE_SLOTS:
		return ""
	return SAVE_DIR + SAVE_PREFIX + str(slot_id) + ".json"

func get_dialogic_slot(slot_id: int) -> String:
	return "slot_" + str(slot_id)

func has_save(slot_id: int) -> bool:
	var path := get_save_path(slot_id)
	return not path.is_empty() and FileAccess.file_exists(path)

func new_game() -> void:
	player_data = PlayerData.new()
	player_data.current_timeline = "timeline"
	is_new_game = true

func save_game(slot_id: int) -> bool:
	var path := get_save_path(slot_id)
	if path.is_empty():
		return false
	current_slot = slot_id
	if not save_data(slot_id):
		return false
	Dialogic.Save.save(get_dialogic_slot(slot_id))
	return true

func save_data(slot_id: int) -> bool:
	var path := get_save_path(slot_id)
	if path.is_empty():
		return false
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		push_error("Gagal menyimpan player data: " + path)
		return false
	file.store_string(JSON.stringify(player_data.to_dict()))
	file.close()
	return true

func read_save(slot_id: int) -> Dictionary:
	var path := get_save_path(slot_id)
	if path.is_empty() or not FileAccess.file_exists(path):
		return {}
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return {}
	var json := JSON.new()
	var error := json.parse(file.get_as_text())
	file.close()
	if error != OK or not json.data is Dictionary:
		return {}
	return json.data

func load_game(slot_id: int) -> bool:
	var data := read_save(slot_id)
	if data.is_empty():
		return false
	player_data.from_dict(data)
	current_slot = slot_id
	is_new_game = false
	# Load save Dialogic yang sesuai dengan slot ini.
	# Dialogic.Save.load_game(get_dialogic_slot(slot_id))
	return true
