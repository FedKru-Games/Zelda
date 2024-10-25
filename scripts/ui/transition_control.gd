extends Control

@export var level_manager: LevelManager

@onready var animation: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	level_manager.level_changed.connect(func(): animation.play("fade_in"))
	level_manager.level_loaded.connect(func(): animation.play("fade_out"))
