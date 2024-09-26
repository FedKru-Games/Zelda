extends CharacterState

var weapon: WeaponData

var _swingTicker = CountDownTicker.new()
var _attackTicker = CountDownTicker.new()


func on_enter():
	var item = character.get_item_in_holster()
	if item is WeaponData:
		weapon = item
		_swingTicker.ticker_ended.connect(_on_swing_end)
		_attackTicker.ticker_ended.connect(_on_attack_end)
		_swingTicker.set_ticker(weapon.swing_duration)
		character.animate("swing_" + character.get_direction_name())
	else:
		pop()
		
func on_exit():
	_swingTicker.ticker_ended.disconnect(_on_swing_end)
	_attackTicker.ticker_ended.disconnect(_on_attack_end)
		
func _on_swing_end():
	character.attack(weapon)
	_attackTicker.set_ticker(weapon.attack_duration)
	character.animate("attack_" + character.get_direction_name())
	
func _on_attack_end():
	pop()

func on_physics_process(delta: float):
	_swingTicker.tick(delta)
	_attackTicker.tick(delta)
	character.velocity = Vector2(0, 0)
	character.move_and_slide()
