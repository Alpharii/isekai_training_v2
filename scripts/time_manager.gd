extends Node

signal time_changed
signal day_changed

const MONTHS: Array[String] = [
	"January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December"
]

const YEAR_NAMES: Array[String] = [
	"First", "Second", "Third", "Fourth", "Fifth",
	"Sixth", "Seventh", "Eighth", "Ninth", "Tenth"
]


func advance_minutes(minutes: int) -> void:
	if minutes <= 0:
		return

	var player = PlayerManager.player_data
	var total_minutes: int = player.game_minutes + minutes
	var days_passed: int = total_minutes / 1440
	player.game_minutes = total_minutes % 1440

	for i in range(days_passed):
		_advance_day(player)

	time_changed.emit()
	if days_passed > 0:
		day_changed.emit()

func _advance_day(player: Resource) -> void:
	player.game_day += 1
	var days_in_month := _get_days_in_month(player.game_month, player.game_year)
	if player.game_day > days_in_month:
		player.game_day = 1
		player.game_month += 1
		if player.game_month > 12:
			player.game_month = 1
			player.game_year += 1

func _get_days_in_month(month: int, year: int) -> int:
	match month:
		2:
			return 29 if _is_leap_year(year) else 28
		4, 6, 9, 11:
			return 30
		_:
			return 31

func _is_leap_year(year: int) -> bool:
	return year % 400 == 0 or (year % 4 == 0 and year % 100 != 0)

func _get_year_name(year: int) -> String:
	if year > 0 and year <= YEAR_NAMES.size():
		return YEAR_NAMES[year - 1]
	return str(year) + "th"

func _get_formatted_time_parts(game_minutes: int) -> Array:
	var hours: int = game_minutes / 60
	var minutes: int = game_minutes % 60
	var period := "AM" if hours < 12 else "PM"
	var display_hours := hours % 12
	if display_hours == 0:
		display_hours = 12
	return [display_hours, minutes, period]


func get_time_text() -> String:
	var player = PlayerManager.player_data
	var time_parts = _get_formatted_time_parts(player.game_minutes)
	
	return "%02d:%02d %s" % [time_parts[0], time_parts[1], time_parts[2]]

func get_date_text() -> String:
	var player = PlayerManager.player_data
	var year_name = _get_year_name(player.game_year)
	
	return "%02d %s, %s Year" % [
		player.game_day,
		MONTHS[player.game_month - 1],
		year_name
	]

func get_datetime_text() -> String:
	var player = PlayerManager.player_data
	var year_name = _get_year_name(player.game_year)
	var time_parts = _get_formatted_time_parts(player.game_minutes)
	
	return "%02d %s, %s Year,\n%02d:%02d %s" % [
		player.game_day,
		MONTHS[player.game_month - 1],
		year_name,
		time_parts[0],
		time_parts[1],
		time_parts[2]
	]
