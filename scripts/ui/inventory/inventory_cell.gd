class_name InventoryCellUiElement extends Container

@export var texture: Texture2D
@export var selected_texture: Texture2D

@onready var background_rect: TextureRect = get_node('BackgroundRect')
@onready var texture_rect: TextureRect = get_node('TextureRect')
@onready var count_label: Label = get_node("HBoxContainer/Label")

signal cell_clicked()

func set_cell(cell: InventoryCell):
	if not cell.is_empty():
		var item = ItemDatabase.items[cell.content.item_id]
		texture_rect.texture = item.texture
		if cell.content.quantity > 99:
			count_label.text = '99'	
		elif cell.content.quantity > 1:
			count_label.text = str(cell.content.quantity)
		else:
			count_label.text = ''
	else:
		texture_rect.texture = null
		count_label.text = ''

func set_selected(selected: bool):
	if selected:
		background_rect.texture = selected_texture
	else:
		background_rect.texture = texture

func _gui_input(event):
	if event is InputEventMouseButton:
		cell_clicked.emit()
