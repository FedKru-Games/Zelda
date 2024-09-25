class_name HealthSystem extends Resource

var max_health: int = 0

signal health_changed(health: int, is_dead: bool)

var _health: int = 0
var _is_dead = false

func _init(max_health: int):
	max_health = max_health
	_health = max_health

func _change_health(new_health: int):
	if new_health <= 0:
		_health = 0
		_is_dead = true
	if new_health > max_health:
		_health = max_health
	health_changed.emit(_health, _is_dead)

func take_damage(damage: int):
	_change_health(_health - damage)
	
func heal(heal: int):
	_change_health(heal)
