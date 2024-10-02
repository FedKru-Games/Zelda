extends CharacterState

var weapon: WeaponData
var item_sprite: Sprite2D
var direction = null
var rotation = null

var _swingTicker = CountDownTicker.new()
var _attackTicker = CountDownTicker.new()

var _attack_started = false

func on_enter():
	super.on_enter()
	var item = character.holster.item
	if item is WeaponData:
		_attack_started = false
		weapon = item
		direction = character.direction
		item_sprite = character.holster.sprite
		item_sprite.z_index = 1
		character.update_direction()
		_rotate_weapon()
		
		_swingTicker.ticker_ended.connect(_on_swing_end)
		_attackTicker.ticker_ended.connect(_on_attack_end)
		_swingTicker.set_ticker(weapon.swing_duration)
	else:
		pop()
		
func on_exit():
	super.on_exit()
	_swingTicker.ticker_ended.disconnect(_on_swing_end)
	_attackTicker.ticker_ended.disconnect(_on_attack_end)
		
func _on_swing_end():
	character.attacker.attack(weapon, character.direction)
	_attack_started = true
	_attackTicker.set_ticker(weapon.attack_duration)
	character.animate("attack_" + character.get_direction_name())
	item_sprite.transform.origin = direction * 16
	
func _on_attack_end():
	pop()
	
func _rotate_weapon():
	rotation = atan2(direction.y, direction.x) - PI / 2
	item_sprite.transform.origin = direction * 4
	item_sprite.rotation = rotation

func on_physics_process(delta: float):
	_swingTicker.tick(delta)
	_attackTicker.tick(delta)
	
	if not _attack_started:
		character.update_direction()
		direction = character.direction.normalized()
		character.animate("swing_" + character.get_direction_name())
		_rotate_weapon()
	
	character.walk()
	character.move_and_slide()
