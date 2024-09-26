extends CharacterState

func on_physics_process(delta: float):
	if not character.has_movement_intention():
		change_state('idle')
		return
	if character.input_run:
		change_state('running')
		return
	character.update_direction()
	character.animate("walk_" + character.get_direction_name())
	character.walk()
	character.move_and_slide()
	melee()
