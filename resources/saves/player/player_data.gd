extends Resource
class_name PlayerData

@export_category("Basic")
@export var player_name: String = "Player"
@export var level: int = 1
@export var experience: int = 0

@export_category("Combat")
@export var hp: int = 100
@export var mp: int = 50

@export var strength: int = 10
@export var stamina: int = 10
@export var dexterity: int = 10
@export var magic: int = 10
@export var wisdom: int = 10
@export var charisma: int = 10
@export var stealth: int = 10
@export var intelligence: int = 10
@export var agility: int = 10

@export_category("Resources")
@export var money: int = 10
@export var max_energy: int = 100
@export var energy: int = 100
@export var max_hungry: int = 100
@export var hungry: int = 100
@export var mood: int = 5

@export_category("Progress")
@export var last_completed_timeline: String = ""


func to_dict() -> Dictionary:
	return {
		"player_name": player_name,
		"level": level,
		"experience": experience,

		"hp": hp,
		"mp": mp,

		"strength": strength,
		"stamina": stamina,
		"dexterity": dexterity,
		"magic": magic,
		"wisdom": wisdom,
		"charisma": charisma,
		"stealth": stealth,
		"intelligence": intelligence,
		"agility": agility,

		"money": money,

		"max_energy": max_energy,
		"energy": energy,

		"max_hungry": max_hungry,
		"hungry": hungry,

		"mood": mood,

		"last_completed_timeline": last_completed_timeline
	}


func from_dict(data: Dictionary) -> void:
	player_name = data.get("player_name", "Player")
	level = data.get("level", 1)
	experience = data.get("experience", 0)

	hp = data.get("hp", 100)
	mp = data.get("mp", 50)

	strength = data.get("strength", 10)
	stamina = data.get("stamina", 10)
	dexterity = data.get("dexterity", 10)
	magic = data.get("magic", 10)
	wisdom = data.get("wisdom", 10)
	charisma = data.get("charisma", 10)
	stealth = data.get("stealth", 10)
	intelligence = data.get("intelligence", 10)
	agility = data.get("agility", 10)

	money = data.get("money", 10)

	max_energy = data.get("max_energy", 100)
	energy = data.get("energy", 100)

	max_hungry = data.get("max_hungry", 100)
	hungry = data.get("hungry", 100)

	mood = data.get("mood", 5)

	last_completed_timeline = data.get("last_completed_timeline", "")
