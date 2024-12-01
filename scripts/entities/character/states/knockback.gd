extends CharacterState

func on_knockback_taken(knockback_strength: float, from: Vector2):
	pass

func on_physics_process(delta: float):
	character.apply_force(character.knockback)
	character.knockback -= character.knockback * delta * 2
		
	character.move_and_slide()
	use_healing_item()
	
	if character.get_real_velocity().length() <= character.data.walk_speed:
		change_state("moving")
		return
