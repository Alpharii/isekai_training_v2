extends Node2D

signal left_button_pressed
signal right_button_pressed

@onready var left_button = %LeftButton
@onready var right_button = %RightButton

func _ready() -> void:
	print("ready game over")

func _on_left_button_pressed() -> void:
	print("signal left")
	left_button_pressed.emit()

func _on_right_button_pressed() -> void:
	print("signal right")
	right_button_pressed.emit()
