extends Node

var _items_array = [
	preload("res://resources/fractions/good.tres"),
	preload("res://resources/fractions/evil.tres"),
	preload("res://resources/fractions/neutral.tres")
]

var items = {}

func _ready():
	for item in _items_array:
		items[item.id] = item
