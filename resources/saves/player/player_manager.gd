extends Node

var player_data: PlayerData = PlayerData.new()
var is_new_game: bool = true

const SAVE_PATH := "user://player_save.json"
const SAVE_SLOT := "slot_1"

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func new_game() -> void:
	player_data = PlayerData.new()
	player_data.current_timeline = "timeline"
	is_new_game = true

func load_game() -> bool:
	if not load_data():
		return false
	is_new_game = false
	return true

func save_game() -> void:
	save_data()
	Dialogic.Save.save(SAVE_SLOT)

func save_data() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("Gagal menyimpan player data.")
		return
	file.store_string(JSON.stringify(player_data.to_dict()))
	file.close()

func read_save() -> Dictionary:
	if not has_save():
		return {}
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return {}
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	file.close()
	if error != OK or not json.data is Dictionary:
		return {}
	return json.data

func load_data() -> bool:
	var data = read_save()
	if data.is_empty():
		return false
	player_data.from_dict(data)
	return true
