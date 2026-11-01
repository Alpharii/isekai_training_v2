extends Node

var previous_scene: String = ""
var current_scene: String = ""

func change_scene(target_path: String) -> void:
	previous_scene = current_scene
	current_scene = target_path
	
	get_tree().change_scene_to_file(target_path)

func back() -> void:
	if previous_scene != "":
		var temp = current_scene
		current_scene = previous_scene
		previous_scene = temp
		
		get_tree().change_scene_to_file(current_scene)
	else:
		print("Tidak ada scene sebelumnya!")
