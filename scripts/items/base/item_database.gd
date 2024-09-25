class_name ItemDatabase extends Node

var _items_array = [
	preload("res://resources/inventory/items/axe.tres")
]

var items = {}

func _ready():
	for item in _items_array:
		items[item.id] = item
