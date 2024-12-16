extends HBoxContainer

@export var character: Character

var cell_scene = preload("res://scenes/ui/inventory/inventory_cell.tscn")

var cells: Array[InventoryCellUiElement] = []

var _selected_cell = null

func _cell_clicked(index: int):
	character.inventory.select_slot(index)

func _inventory_size_changed(size: int):
	while len(cells) > size:
		cells.back().cell_clicked.disconnect(_cell_clicked)
		var cell = cells.pop_back()
		remove_child(cell)
		cell.queue_free()
	
	var index = len(cells)
	
	while len(cells) < size:
		cells.push_back(cell_scene.instantiate())
		cells.back().cell_clicked.connect(_cell_clicked.bind(index))
		add_child(cells.back())
		index += 1
		
	for i in range(size):
		_inventory_cell_changed(i, character.inventory.get_cell(i))
		if character.inventory.selected_slot == i:
			_selected_item_changed(character.inventory.get_item_stack(i), i)

func _inventory_cell_changed(index: int, cell: InventoryCell):
	cells[index].set_cell(cell)

func _selected_item_changed(item: ItemStack, slot: int):
	if _selected_cell != null:
		cells[_selected_cell].set_selected(false)
	_selected_cell = slot
	cells[_selected_cell].set_selected(true)

func _ready():
	_inventory_size_changed(character.inventory.size)
	
	character.inventory.inventory_size_changed.connect(_inventory_size_changed)
	character.inventory.inventory_cell_changed.connect(_inventory_cell_changed)
	character.inventory.selected_item_changed.connect(_selected_item_changed)
