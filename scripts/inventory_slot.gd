extends TextureRect

signal slot_clicked(slot_data: Dictionary)

@onready var item_icon: TextureRect = %ItemIcon
@onready var quantity_label: Label = %QuantityLabel

var current_slot_data: Dictionary

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	item_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	quantity_label.mouse_filter = Control.MOUSE_FILTER_IGNORE

func setup(slot: Dictionary) -> void:
	current_slot_data = slot

	if slot.item == null:
		item_icon.texture = null
		quantity_label.text = ""
		return

	item_icon.texture = slot.item.texture
	quantity_label.text = str(slot.quantity) if slot.quantity > 1 else ""
	tooltip_text = slot.item.displayName

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("clicked")

			if current_slot_data.item == null:
				return

			slot_clicked.emit(current_slot_data)
