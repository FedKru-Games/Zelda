extends Camera2D

@export var target: Node2D

func _ready() -> void:
	EventBus.player_teleported.connect(func(): 
		var old_smoothing = position_smoothing_enabled
		var old_drag_h = drag_horizontal_enabled
		var old_drag_v = drag_vertical_enabled
		
		position_smoothing_enabled = false
		drag_horizontal_enabled = false
		drag_vertical_enabled = false
		
		position = target.transform.origin
		
		await get_tree().physics_frame
		
		position_smoothing_enabled = old_smoothing
		drag_horizontal_enabled = old_drag_h
		drag_vertical_enabled = old_drag_v)

func _physics_process(delta: float):
	var target_origin = target.transform.get_origin()
	position = target_origin
