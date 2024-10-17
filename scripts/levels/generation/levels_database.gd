extends Node

var levels = {}

func _ready() -> void:
	var path = "res://scenes/levels/generation"
	
	var directory = DirAccess.open(path)
	var level_types = directory.get_directories()
	
	for level_type in level_types:
		var nested_dir = DirAccess.open(path + '/' + level_type)
		
		var files = nested_dir.get_files()
		
		var levels_map = {}
	
		for file in files:
			var location_type = file.split("_", true, 1)[0]
			
			if levels_map.get(location_type) == null:
				levels_map[location_type] = []
				
			levels_map[location_type].append(path + '/' + level_type + '/' + file)
			
		levels[level_type] = levels_map
