class_name LevelNode extends Node2D

var floor_item_scene = preload("res://scenes/levels/objects/floor_item.tscn")

var width = 0.0
var doors = {}
var locations: Array[Location] = []

func _ready() -> void:
	EventBus.character_died.connect(on_character_died)
	
func _exit_tree() -> void:
	EventBus.character_died.disconnect(on_character_died)

func set_locations(location_scenes: Array[PackedScene]):
	width = 0
	doors = []
	locations.clear()
	
	for item in location_scenes:
		var instance = item.instantiate() as Location
		instance.transform.origin = Vector2(width, 0)
		width += instance.width * 16
		locations.append(instance)
		add_child(instance)
		doors = instance.get_doors()
		
func on_character_died(character: Character):
	for item in character.inventory.get_items():
		if item.content == null or item.content.get_item() is WeaponData:
			continue
		var floor_item: FloorItem = floor_item_scene.instantiate()
		floor_item.item_stack = item.content
		floor_item.position = character.position
		floor_item.velocity = Vector2(randf_range(-100, 100), randf_range(-100, 100))
		call_deferred("add_child", floor_item)
