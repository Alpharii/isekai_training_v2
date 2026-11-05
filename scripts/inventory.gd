extends Node2D

signal inventory_slot_clicked(slot_data: Dictionary)

const INVENTORY_SLOT = preload("res://scenes/components/inventory_slot.tscn")

@onready var item_grid: GridContainer = %ItemGrid
@onready var item_name: Label = %ItemName
@onready var item_texture: TextureRect = %ItemTexture
@onready var item_quantity: Label = %ItemQuantity
@onready var item_type: Label = %TypeLabel
@onready var item_description: Label = %DescriptionLabel
@onready var item_effects: Label = %EffectsLabel

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
	if not slot_data or not slot_data.has("item") or not slot_data.item:
		return

	var item = slot_data.item

	item_name.text = item.displayName
	item_type.text = "Type :" + item.item_type.capitalize()
	item_description.text = item.description
	item_texture.texture = item.texture
	item_quantity.text = str(slot_data.quantity)

	display_item_effects(item)

	inventory_slot_clicked.emit(slot_data)

func display_item_effects(item: ItemData) -> void:
	var effect_text: Array[String] = []

	for effect in item.effects:
		if effect is HungerEffect:
			effect_text.append("%+d Hunger" % effect.amount)
		elif effect is StatGainEffect:
			print(item.effects)
			#effect_text.append("%+d Strength" % effect.amount)
		elif effect is EnergyEffect:
			effect_text.append("%+d HP" % effect.amount)

	item_effects.text = "\n".join(effect_text) if not effect_text.is_empty() else "-"

func _on_back_button_pressed() -> void:
	SceneManager.back()
