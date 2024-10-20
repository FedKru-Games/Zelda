class_name LevelManager extends Node

@export var player: Character

var level_generator = LevelGenerator.new()

var door_connections = {}

signal level_changed()

signal level_loaded()

var switch_ticker = CountDownTicker.new()

func _physics_process(delta: float) -> void:
	if not switch_ticker.is_completed():
		switch_ticker.tick(delta)

func _ready() -> void:
	_switch_level(Door.Position.LEFT)
	
func _on_door_entered(user: Node2D, door: Door):
	if user == player:	
		get_tree().paused = true
		level_changed.emit()
		await get_tree().create_timer(1).timeout
		_switch_level(Door.invertPosition(door.door_position))

func _switch_level(door_position: Door.Position):
	for child in get_children():
		remove_child(child)
	
	for door in door_connections.keys():
		var connection = door_connections[door]
		(door as Door).door_entered.disconnect(connection)
	
	var level = level_generator.generate_level('grass')
	
	add_child(level)
	player.transform.origin = level.doors[door_position].transform.origin
	
	get_tree().paused = false
	
	EventBus.player_teleported.emit()
	
	for location in level.locations:
		for point in location.get_spawn_points():
			if point is SpawnPoint:
				point.spawn()
	
	for door in level.doors.values():
		var callable = _on_door_entered.bind(door)
		door_connections[door] = callable
		(door as Door).door_entered.connect(callable)
		
	level_loaded.emit()	
