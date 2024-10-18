class_name LevelManager extends Node

@export var player: Character

var level_generator = LevelGenerator.new()

func _ready() -> void:
	var level = level_generator.generate_level('grass')
	add_child(level)
	player.transform.origin = level.doors[Door.Position.LEFT].transform.origin
	
	for location in level.locations:
		for point in location.get_spawn_points():
			if point is SpawnPoint:
				point.spawn()

func _switch_level():
	pass
