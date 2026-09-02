# player_data.gd
extends Resource
class_name PlayerData

@export var player_name: String = "Player"
@export var level: int = 1
@export var exp: int = 0
@export var hp: int = 100
@export var mp: int = 50
@export var strength: int = 10
@export var agility: int = 10
@export var last_completed_timeline: String = "" 

# Fungsi bantu untuk convert ke Dictionary (dipakai buat save JSON)
func to_dict() -> Dictionary:
	return {
		"player_name": player_name,
		"level": level,
		"exp": exp,
		"hp": hp,
		"mp": mp,
		"strength": strength,
		"agility": agility,
		"last_completed_timeline": last_completed_timeline
	}

# Fungsi bantu untuk load dari Dictionary (dipakai buat load JSON)
func from_dict(data: Dictionary) -> void:
	player_name = data.get("player_name", "Player")
	level = data.get("level", 1)
	exp = data.get("exp", 0)
	hp = data.get("hp", 100)
	mp = data.get("mp", 50)
	strength = data.get("strength", 10)
	agility = data.get("agility", 10)
	last_completed_timeline = data.get("last_completed_timeline", "")
