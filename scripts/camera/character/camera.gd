extends Camera2D

@export var target: Node2D

func _physics_process(delta: float):
	var target_origin = target.transform.get_origin()	
	position = round(target_origin)
