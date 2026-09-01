extends Node2D

func _ready() -> void:
	pass # Replace with function body.

func _on_next_turn_button_pressed() -> void:
	Dialogic.start("timeline")
