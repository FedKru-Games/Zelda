class_name LevelGenerator extends Resource

func _get_random_location(locations: Array) -> PackedScene:
	var index = randi_range(0, len(locations) - 1)
	return load(locations[index])
	

func generate_level(level_type: String) -> LevelNode:
	var locations = LevelsDatabase.levels.get(level_type)
	
	var packed_locations = [
		_get_random_location(locations['arena']),
	]
	
	var location_nodes: Array[PackedScene] = []
	
	for item in packed_locations:
		location_nodes.append(item)
		
	var level = PackedScenes.level_node_scene.instantiate()
	
	level.set_locations(location_nodes)
	
	return level
	
