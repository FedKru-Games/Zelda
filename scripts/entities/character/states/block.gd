extends CharacterState

var ticker = CountDownTicker.new()
var weapon: WeaponData = null

func _ready() -> void:
	ticker.ticker_ended.connect(_on_block_end)

func on_enter():
	var item = character.holster.item
	if item is WeaponData:
		character.velocity = Vector2.ZERO
		weapon = item
		character.blocker.enable()
		ticker.set_ticker(weapon.block_duration)
		character.audio.block.play()
	else:
		pop()

func on_physics_process(delta: float):
	character.animate("swing_" + character.get_direction_name())
	ticker.tick(delta)
	character.move_and_slide()
	
func on_exit():
	character.blocker.disable()
	character.block_cooldown.set_ticker(weapon.block_cooldown)

func _on_block_end():
	pop()

func on_damage_taken(damage: int):
	pass

func on_knockback_taken(knockback_strength: float, from: Vector2):
	pass
