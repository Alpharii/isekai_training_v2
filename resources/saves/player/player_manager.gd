# player_manager.gd
extends Node
# HAPUS class_name-nya, tidak perlu untuk Autoload

var player_data: PlayerData = PlayerData.new()
const SAVE_SLOT := "slot_1"

func save_game() -> void:
	save_data()
	Dialogic.Save.save(SAVE_SLOT)

func save_data() -> void:
	var file = FileAccess.open("user://player_save.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(player_data.to_dict()))
		file.close()

func load_data() -> void:
	if not FileAccess.file_exists("user://player_save.json"):
		return
	var file = FileAccess.open("user://player_save.json", FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		var json = JSON.new()
		if json.parse(json_string) == OK:
			player_data.from_dict(json.get_data())
