class_name LevelNode extends Node2D

var width = 0.0
var start_point = null

var locations: Array[Location] = []

func set_locations(location_scenes: Array[PackedScene]):
	width = 0
	start_point = null
	locations.clear()
	
	for item in location_scenes:
		var instance = item.instantiate() as Location
		instance.transform.origin = Vector2(width, 0)
		width += instance.width * 16
		locations.append(instance)
		add_child(instance)
		if start_point == null and instance.has_start_point():
			start_point = instance.get_start_node()
