class_name StatRankHelper
extends RefCounted


static func get_rank(value: int) -> String:
	if value >= 1150:
		return "SS+"
	elif value >= 1100:
		return "SS"
	elif value >= 1050:
		return "S+"
	elif value >= 1000:
		return "S"
	elif value >= 950:
		return "A+"
	elif value >= 900:
		return "A"
	elif value >= 850:
		return "B+"
	elif value >= 800:
		return "B"
	elif value >= 700:
		return "C+"
	elif value >= 600:
		return "C"
	elif value >= 500:
		return "D+"
	elif value >= 400:
		return "D"
	elif value >= 300:
		return "E+"
	elif value >= 200:
		return "E"
	elif value >= 100:
		return "F+"
	else:
		return "F"


static func set_rank(label: Label, value: int) -> void:
	var rank := get_rank(value)

	label.text = rank

	var material := label.material as ShaderMaterial

	if material == null:
		return

	match rank:
		"SS+":
			material.set_shader_parameter("warna_atas", Color("#ffffff"))
			material.set_shader_parameter("warna_tengah", Color("#ffdf4d"))
			material.set_shader_parameter("warna_bawah", Color("#b8000b"))

		"SS":
			material.set_shader_parameter("warna_atas", Color("#fff8c4"))
			material.set_shader_parameter("warna_tengah", Color("#ffd700"))
			material.set_shader_parameter("warna_bawah", Color("#b8860b"))

		"S+":
			material.set_shader_parameter("warna_atas", Color("#ffffff"))
			material.set_shader_parameter("warna_tengah", Color("#ff6666"))
			material.set_shader_parameter("warna_bawah", Color("#b30000"))

		"S":
			material.set_shader_parameter("warna_atas", Color("#ffcccc"))
			material.set_shader_parameter("warna_tengah", Color("#ff4444"))
			material.set_shader_parameter("warna_bawah", Color("#990000"))

		"A+":
			material.set_shader_parameter("warna_atas", Color("#ffffff"))
			material.set_shader_parameter("warna_tengah", Color("#ff9d4d"))
			material.set_shader_parameter("warna_bawah", Color("#d35400"))

		"A":
			material.set_shader_parameter("warna_atas", Color("#ffe0c2"))
			material.set_shader_parameter("warna_tengah", Color("#ff8c42"))
			material.set_shader_parameter("warna_bawah", Color("#b84d00"))

		"B+":
			material.set_shader_parameter("warna_atas", Color("#ffffff"))
			material.set_shader_parameter("warna_tengah", Color("#66b3ff"))
			material.set_shader_parameter("warna_bawah", Color("#0066cc"))

		"B":
			material.set_shader_parameter("warna_atas", Color("#cce6ff"))
			material.set_shader_parameter("warna_tengah", Color("#4da6ff"))
			material.set_shader_parameter("warna_bawah", Color("#0052a3"))

		"C+":
			material.set_shader_parameter("warna_atas", Color("#ffffff"))
			material.set_shader_parameter("warna_tengah", Color("#66dd88"))
			material.set_shader_parameter("warna_bawah", Color("#168a3d"))

		"C":
			material.set_shader_parameter("warna_atas", Color("#d4f5dc"))
			material.set_shader_parameter("warna_tengah", Color("#55cc77"))
			material.set_shader_parameter("warna_bawah", Color("#167a38"))

		"D+":
			material.set_shader_parameter("warna_atas", Color("#ffffff"))
			material.set_shader_parameter("warna_tengah", Color("#bbbbbb"))
			material.set_shader_parameter("warna_bawah", Color("#666666"))

		"D":
			material.set_shader_parameter("warna_atas", Color("#eeeeee"))
			material.set_shader_parameter("warna_tengah", Color("#aaaaaa"))
			material.set_shader_parameter("warna_bawah", Color("#555555"))

		"E+":
			material.set_shader_parameter("warna_atas", Color("#ffffff"))
			material.set_shader_parameter("warna_tengah", Color("#c58cff"))
			material.set_shader_parameter("warna_bawah", Color("#7020b8"))

		"E":
			material.set_shader_parameter("warna_atas", Color("#e5ccff"))
			material.set_shader_parameter("warna_tengah", Color("#aa66dd"))
			material.set_shader_parameter("warna_bawah", Color("#5c1a8a"))

		"F+":
			material.set_shader_parameter("warna_atas", Color("#ffffff"))
			material.set_shader_parameter("warna_tengah", Color("#77ddff"))
			material.set_shader_parameter("warna_bawah", Color("#1685a8"))

		"F":
			material.set_shader_parameter("warna_atas", Color("#dddddd"))
			material.set_shader_parameter("warna_tengah", Color("#999999"))
			material.set_shader_parameter("warna_bawah", Color("#444444"))
