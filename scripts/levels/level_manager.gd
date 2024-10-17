class_name LevelManager extends Node

@export var player: Character

var level_generator = LevelGenerator.new()

func _ready() -> void:
	var level = level_generator.generate_level('grass')
	add_child(level)
	if level.start_point != null:
		player.transform.origin = level.start_point
	
	for location in level.locations:
		if location.has_spawn_points():
			for point in location.get_spawn_points():
				if point is SpawnPoint:
					point.spawn()
