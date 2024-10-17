extends CharacterState

func on_physics_process(delta: float):
	if not character.has_movement_intention():
		change_state('idle')
		return
	if not character.input_run:
		change_state('moving')
		return
	character.update_direction()
	character.animate("run_" + character.get_direction_name())
	character.run()
	character.move_and_slide()
	melee()
	use_healing_item()
