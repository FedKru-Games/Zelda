extends CharacterState

func on_enter():
	character.animate("die")
	character.holster.sprite.visible = false

func on_health_changed(health: int, is_dead: bool):
	pass
	
func on_damage_taken(damage: int):
	pass

func on_exit():
	character.holster.sprite.visible = true

func on_knockback_taken(knockback_strength: float, from: Vector2):
	pass
