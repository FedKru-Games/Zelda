class_name ItemHolster extends Node2D

@onready var sprite: Sprite2D = get_node("ItemSprite")

var inventory: Inventory = null : set = set_inventory

var quantity: int = 0
var item: ItemData = null

func set_inventory(new_inventory: Inventory):
	if inventory != null:
		inventory.selected_item_changed.disconnect(_listen_inventory_item)
	inventory = new_inventory
	inventory.selected_item_changed.connect(_listen_inventory_item)
	
func _listen_inventory_item(stack: ItemStack, slot: int):
	quantity = stack.quantity
	if stack.item_id != null:
		item = ItemDatabase.items[stack.item_id]
		sprite.texture = item.holster_texture
	else:
		item = null
		quantity = 0
		sprite.text = null
