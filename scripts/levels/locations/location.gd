class_name Location extends Node2D

@export var width: int = 16
@export var height: int = 16

func has_start_point() -> bool:
	return has_node("StartPoint")
	
func get_start_node() -> Vector2:
	var node: Node2D = get_node_or_null("StartPoint")
	
	if node == null:
		return Vector2.ZERO
		
	return node.transform.get_origin()

func has_spawn_points() -> bool:
	return has_node("Spawns")

func get_spawn_points() -> Array[Node]:
	return get_node("Spawns").get_children()
	
