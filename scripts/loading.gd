extends Node2D

func _ready() -> void:
	print("is new game", PlayerManager.is_new_game)
	if PlayerManager.is_new_game:
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		Dialogic.start(PlayerManager.player_data.current_timeline)
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_timeline_ended() -> void:
	print("Timeline selesai!")
	PlayerManager.player_data.last_completed_timeline = PlayerManager.player_data.current_timeline
	PlayerManager.player_data.current_timeline = ""
	PlayerManager.save_game()
	PlayerManager.is_new_game = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
