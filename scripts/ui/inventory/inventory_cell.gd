class_name InventoryCellUiElement extends Container

@export var texture: Texture2D
@export var selected_texture: Texture2D

@onready var background_rect: TextureRect = get_node('BackgroundRect')
@onready var texture_rect: TextureRect = get_node('TextureRect')

signal cell_clicked()

func set_cell(cell: InventoryCell):
	if not cell.is_empty():
		var item = ItemDatabase.items[cell.content.item_id]
		texture_rect.texture = item.texture
	else:
		texture_rect.texture = null

func set_selected(selected: bool):
	if selected:
		background_rect.texture = selected_texture
	else:
		background_rect.texture = texture

func _gui_input(event):
	if event is InputEventMouseButton:
		cell_clicked.emit()
