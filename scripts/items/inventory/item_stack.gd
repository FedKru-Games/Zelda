class_name ItemStack extends Resource

@export var item_id: String = ""
@export var quantity: int = 0

static func create(item_id, quantity: int) -> ItemStack:
	var stack = ItemStack.new()
	stack.item_id = item_id
	stack.quantity = quantity
	return stack
	
	
func get_item() -> ItemData:
	return ItemDatabase.items[item_id]
