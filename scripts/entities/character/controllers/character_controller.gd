class_name CharacterController extends Node

@onready var character: Character = get_node('Character')

func _inventory_input(event: InputEvent):
	var item_index = null
	
	for i in range(5):
		if event.is_action("item_" + str(i + 1)):
			character.inventory.select_slot(i)
			return

func _input(event):
	_inventory_input(event)

func _physics_process(delta):
	
	var input_left = Input.get_action_strength("move_left")
	var input_right = Input.get_action_strength("move_right")
	var input_up = Input.get_action_strength("move_up")
	var input_down = Input.get_action_strength("move_down")
	var input_run = Input.is_action_pressed("move_run")
	var input_attack = Input.is_action_just_pressed("weapon_attack")
	var input_use = Input.is_action_just_pressed("use")
	
	character.input_x = input_right - input_left
	character.input_y = input_down - input_up
	character.input_run = input_run
	character.input_attack = input_attack
