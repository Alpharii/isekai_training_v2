extends Node2D

signal inventory_slot_clicked(slot_data: Dictionary)

const INVENTORY_SLOT = preload("res://scenes/components/inventory_slot.tscn")

@onready var item_grid: GridContainer = %ItemGrid

func _ready() -> void:
	var bread = preload("res://resources/items/data/bread.tres")
	var green_apple = preload("res://resources/items/data/green_apple.tres")

	InventoryManager.debug_add_item(bread, 10)
	InventoryManager.debug_add_item(green_apple, 15)

	InventoryManager.inventory_changed.connect(refresh_inventory)
	refresh_inventory()

func refresh_inventory() -> void:
	for child in item_grid.get_children():
		child.queue_free()

	for slot_data in InventoryManager.slots:
		var slot = INVENTORY_SLOT.instantiate()
		item_grid.add_child(slot)
		slot.setup(slot_data)
		slot.slot_clicked.connect(_on_slot_clicked)

func _on_slot_clicked(slot_data: Dictionary) -> void:
	print("Item clicked: ", slot_data.item.displayName)
	print("Quantity: ", slot_data.quantity)
	print("Clicked slot: ", slot_data)
	inventory_slot_clicked.emit(slot_data)
	

func _on_back_button_pressed() -> void:
	SceneManager.back()
