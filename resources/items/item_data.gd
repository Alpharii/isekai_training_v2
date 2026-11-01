class_name ItemData
extends Resource

@export var id: StringName
@export var displayName: String = ""
@export var description: String = "Deskripsi item"
@export var texture: Texture2D
@export_enum(
	"consumable", 
	"equipment", 
	"utility", 
	"others"
) var item_type: String = "others"
@export var effects: Array[TrainingEffect] = []
@export var stackable: bool = true
@export var max_stack: int = 99
