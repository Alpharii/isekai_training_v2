extends Node2D

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("timeline")

func _on_timeline_ended() -> void:
	print("Timeline selesai!")
	PlayerManager.player_data.last_completed_timeline = "timeline"
	PlayerManager.save_game()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
