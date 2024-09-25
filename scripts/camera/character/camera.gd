extends Camera2D

@export var target: Node2D
@export var target_bounds: Vector2

func _process(delta):
	var target_origin = target.transform.get_origin()
	var center = get_screen_center_position()
	var pos_delta = target_origin - center

	var direction = Vector2(0, 0)
	
	if abs(pos_delta.x) > target_bounds.x:
		direction.x = pos_delta.x
		
	if abs(pos_delta.y) > target_bounds.y:
		direction.y = pos_delta.y	
	
	position = center.lerp(center + direction, delta)
	
	
