extends Node

signal inventory_changed

const MAX_SLOTS = 24

var slots: Array[Dictionary] = []

func _ready() -> void:
	initialize_slots()

func initialize_slots() -> void:
	slots.clear()

	for i in range(MAX_SLOTS):
		slots.append({"item": null, "quantity": 0})

func load_from_player_data() -> void:
	initialize_slots()

	var player_data = PlayerManager.player_data
	if player_data == null:
		return

	for i in range(min(player_data.inventory_slots.size(), MAX_SLOTS)):
		var saved_slot: Dictionary = player_data.inventory_slots[i]
		var item_path: String = saved_slot.get("item_path", "")
		var quantity: int = saved_slot.get("quantity", 0)

		if item_path.is_empty() or quantity <= 0:
			continue

		var item = load(item_path) as ItemData
		if item == null:
			continue

		slots[i] = {
			"item": item,
			"quantity": quantity
		}

	inventory_changed.emit()

func save_to_player_data() -> void:
	var player_data = PlayerManager.player_data
	if player_data == null:
		return

	var saved_slots: Array[Dictionary] = []

	for slot in slots:
		var item: ItemData = slot.item
		saved_slots.append({
			"item_path": item.resource_path if item != null else "",
			"quantity": slot.quantity
		})

	player_data.inventory_slots = saved_slots

func add_item(item: ItemData, amount: int = 1) -> bool:
	if item == null or amount <= 0:
		return false

	var remaining = amount

	if item.stackable:
		for slot in slots:
			if slot.item == null or slot.item.id != item.id:
				continue

			var space = item.max_stack - slot.quantity
			var added = min(space, remaining)
			slot.quantity += added
			remaining -= added

			if remaining <= 0:
				save_to_player_data()
				inventory_changed.emit()
				return true

	for slot in slots:
		if slot.item != null:
			continue

		var added = min(item.max_stack, remaining) if item.stackable else 1
		slot.item = item
		slot.quantity = added
		remaining -= added

		if remaining <= 0:
			save_to_player_data()
			inventory_changed.emit()
			return true

	save_to_player_data()
	inventory_changed.emit()
	return false

func remove_item(item: ItemData, amount: int = 1) -> bool:
	if item == null or amount <= 0:
		return false

	var total = get_item_count(item)
	if total < amount:
		return false

	var remaining = amount

	for slot in slots:
		if slot.item == null or slot.item.id != item.id:
			continue

		var removed = min(slot.quantity, remaining)
		slot.quantity -= removed
		remaining -= removed

		if slot.quantity <= 0:
			slot.item = null
			slot.quantity = 0

		if remaining <= 0:
			break

	save_to_player_data()
	inventory_changed.emit()
	return true

func get_item_count(item: ItemData) -> int:
	if item == null:
		return 0

	var total = 0

	for slot in slots:
		if slot.item != null and slot.item.id == item.id:
			total += slot.quantity

	return total
	
func debug_add_item(item: ItemData, amount: int = 1) -> void:
	if not OS.is_debug_build():
		return

	if add_item(item, amount):
		print("DEBUG: Added ", amount, "x ", item.displayName)
	else:
		print("DEBUG: Inventory full!")
