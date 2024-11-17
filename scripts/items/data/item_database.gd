extends Node

var _items_array: Array[ItemData] = [
	preload("res://resources/inventory/weapons/axe.tres"),
	preload("res://resources/inventory/weapons/battle_axe.tres"),
	preload("res://resources/inventory/weapons/katana.tres"),
	preload("res://resources/inventory/weapons/sai.tres"),
	preload("res://resources/inventory/consumables/health_potion.tres")
]

var items = {}

func _ready():
	for item in _items_array:
		items[item.id] = item
