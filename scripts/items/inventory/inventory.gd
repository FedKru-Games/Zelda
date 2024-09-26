class_name Inventory extends Resource

signal selected_item_changed(item: ItemStack, slot: int)

var size: int
var selected_slot = 0

var _items: Array[InventoryCell] = []

func _init(size: int):
	self.size = size
	_generate_items_array()

func select_slot(position: int):
	if position > size or position < 0:
		return
	
	selected_slot = position
	selected_item_changed.emit(get_item_stack(selected_slot), selected_slot)
	
	
func add_item(item_id: String, quantity: int = 0) -> bool:
	var index = 0
	for item in _items:
		if item.is_empty():
			item.content = ItemStack.new(item_id, quantity)
			if index == selected_slot:
				selected_item_changed.emit(get_item_stack(index), selected_slot)
			return true
		index += 1
	return false
	
func get_item_stack(position: int) -> ItemStack:
	if position > size or position < 0:
		return null
	return _items[position].content

func _generate_items_array():
	var inventory: Array[InventoryCell] = []
	for i in range(size):
		inventory.append(InventoryCell.new())
	_items = inventory
	

class InventoryCell extends Resource:
	var content: ItemStack = null
	
	func is_empty() -> bool:
		return content == null
