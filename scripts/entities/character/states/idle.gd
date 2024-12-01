extends CharacterState

func on_physics_process(delta: float):
	if character.has_movement_intention():
		if character.input_run:
			change_state('running')
		else:
			change_state('moving')
		return
	character.animate("idle_" + character.get_direction_name())
	character.walk()
	character.move_and_slide()
	block(delta)
	melee()
	use_healing_item()
