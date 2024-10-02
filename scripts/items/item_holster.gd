class_name ItemHolster extends Node2D

@onready var sprite: Sprite2D = get_node("ItemSprite")

var inventory: Inventory

var quantity: int = 0
var item: ItemData = null

func init(inventory: Inventory):
	self.inventory = inventory
	inventory.selected_item_changed.connect(_listen_inventory_item)
	
func _listen_inventory_item(stack: ItemStack, slot: int):
	if stack != null and stack.item_id != null:
		quantity = stack.quantity
		item = ItemDatabase.items[stack.item_id]
		sprite.texture = item.holster_texture
	else:
		item = null
		quantity = 0
		sprite.texture = null
