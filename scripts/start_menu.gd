extends Node2D

func _ready() -> void:
	pass # Replace with function body.

func _on_new_game_pressed() -> void:
	print("test")
	get_tree().change_scene_to_file("res://scenes/loading.tscn")

func _on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
