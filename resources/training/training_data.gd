extends Resource
class_name TrainingData

@export var id: StringName
@export var display_name: String
@export var energy_cost: int = 20
@export var effects: Array[TrainingEffect] = []
@export var mood_multiplier_enabled: bool = true
