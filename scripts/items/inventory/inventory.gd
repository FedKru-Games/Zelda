class_name Inventory extends Resource

signal selected_item_changed(item: ItemStack, slot: int)

signal inventory_size_changed(size: int)

signal inventory_cell_changed(index: int, cell: InventoryCell)

var size: int
var selected_slot = 0

var _items: Array[InventoryCell] = []

func _init(size: int):
	self.size = size
	_generate_items_array()

func select_slot(position: int):
	if position > size - 1 or position < 0:
		return
	
	selected_slot = position
	selected_item_changed.emit(get_item_stack(selected_slot), selected_slot)

func remove(position: int = selected_slot, amount: int = 1):
	if position > size or position < 0:
		return null
	
	_items[position].content.quantity -= 1
	if _items[position].content.quantity <= 0:
		_items[position].content = null
	
	if selected_slot == position:
		selected_item_changed.emit(_items[position].content, position)
			
	inventory_cell_changed.emit(position, _items[position])
	
func add_item(item_id: String, quantity: int = 0) -> bool:
	var index = 0
	for item in _items:
		if item.is_empty():
			item.content = ItemStack.new(item_id, quantity)
			inventory_cell_changed.emit(index, item)
			if index == selected_slot:
				selected_item_changed.emit(get_item_stack(index), selected_slot)
			return true
		index += 1
	return false
	
func get_item_stack(position: int) -> ItemStack:
	if position > size or position < 0:
		return null
	return _items[position].content
	
func get_cell(index: int) -> InventoryCell:
	if index > len(_items) or index < 0:
		return null
	
	return _items[index]

func _generate_items_array():
	var inventory: Array[InventoryCell] = []
	for i in range(size):
		inventory.append(InventoryCell.new())
	_items = inventory
	inventory_size_changed.emit(size)
	
