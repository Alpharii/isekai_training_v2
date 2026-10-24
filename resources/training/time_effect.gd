extends TrainingEffect
class_name TimeEffect

@export_range(0, 1440) var minutes_passed: int = 60

func apply(_player: Resource, _context: Dictionary) -> Dictionary:
	TimeManager.advance_minutes(minutes_passed)
	return {
		"minutes_passed": minutes_passed
	}
