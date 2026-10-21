
extends Control

signal load_requested(slot_id: int)
signal save_requested(slot_id: int)

@onready var player_name = %PlayerName
@onready var player_level = %PlayerLevel
@onready var game_time = %PlayerGameTime
@onready var play_time = %PlayerPlayTime

const MONTHS = [
	"January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December"
]
const YEAR_NAMES = [
	"First Year", "Second Year", "Third Year", "Fourth Year",
	"Fifth Year", "Sixth Year", "Seventh Year", "Eighth Year",
	"Ninth Year", "Tenth Year"
]

var slot_id: int = 1
var has_data: bool = false
var mode: String = "load"

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if mode == "save":
			save_requested.emit(slot_id)
		elif has_data:
			load_requested.emit(slot_id)

func setup(data: Dictionary, id: int, slot_mode: String = "load") -> void:
	slot_id = id
	mode = slot_mode
	has_data = not data.is_empty()

	if not has_data:
		player_name.text = "Empty Slot %d" % slot_id
		player_level.text = "-"
		game_time.text = "-"
		play_time.text = "-"
		return

	player_name.text = data.get("player_name", "Player")
	player_level.text = "Level %d" % data.get("level", 1)
	game_time.text = format_game_time(data)
	play_time.text = format_play_time(data.get("play_time_seconds", 0.0))

func format_game_time(data: Dictionary) -> String:
	var month_index: int = clampi(data.get("game_month", 1), 1, 12) - 1
	var day: int = data.get("game_day", 1)
	var year: int = data.get("game_year", 1)
	var year_name: String = YEAR_NAMES[year - 1] if year >= 1 and year <= YEAR_NAMES.size() else "Year %d" % year
	return "%s %02d, %s" % [MONTHS[month_index], day, year_name]

func format_play_time(seconds: float) -> String:
	var hours: int = int(seconds / 3600.0)
	return "%dh played" % hours
