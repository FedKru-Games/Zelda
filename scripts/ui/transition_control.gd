extends Control

@export var level_manager: LevelManager

@onready var rect: ColorRect = get_node("ColorRect")
@onready var rect_mat: ShaderMaterial = rect.material

var cutoff = 0.0
var fading_in = false

func _ready() -> void:
	level_manager.level_changed.connect(func():
		fading_in = true)

	level_manager.level_loaded.connect(func(): 
		fading_in = false)

func _process(delta: float) -> void:
	if fading_in:
		if cutoff > 0:
			cutoff = clampf(cutoff - delta / 0.5, 0, 1)
			rect_mat.set_shader_parameter("cutoff", cutoff)
	elif cutoff < 1:
		cutoff = clampf(cutoff + delta / 0.5, 0, 1)
		rect_mat.set_shader_parameter("cutoff", cutoff)
