class_name Location extends Node2D

@export var width: int = 16
@export var height: int = 16

func get_doors() -> Dictionary:
	var doors = get_node("Doors")
	var doors_map = {}
	for door in doors.get_children():
		if door is Door:
			doors_map[door.door_position] = door
	return doors_map
	
func get_spawn_points() -> Array[Node]:
	if not has_node("Spawns"):
		return []
	return get_node("Spawns").get_children()
