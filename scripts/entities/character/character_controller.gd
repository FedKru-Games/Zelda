extends Node

@onready var character: Character = get_node('Character')

func _physics_process(delta):
	var input_left = Input.get_action_strength("move_left")
	var input_right = Input.get_action_strength("move_right")
	var input_up = Input.get_action_strength("move_up")
	var input_down = Input.get_action_strength("move_down")
	var input_run = Input.is_action_pressed("move_run")
	
	character.input_x = input_right - input_left
	character.input_y = input_down - input_up
	character.input_run = input_run
