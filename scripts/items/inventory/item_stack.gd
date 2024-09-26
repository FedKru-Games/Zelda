class_name ItemStack extends Resource

var item_id = null
var quantity: int = 0

func _init(item_id, quantity: int):
	self.item_id = item_id
	self.quantity = quantity
