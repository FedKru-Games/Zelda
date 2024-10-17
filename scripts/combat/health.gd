class_name Health extends Resource


signal health_changed(health: int, is_dead: bool)
signal max_health_changed(max_health: int)

var max_health: int = 0 : set = _change_max_health
var health: int = 0 : set = _change_health

var is_dead = false

func _init(max_health: int):
	max_health = max_health
	health = max_health

func _change_max_health(new_health: int):
	max_health = new_health
	if health > max_health:
		health = max_health
	max_health_changed.emit(max_health)

func _change_health(new_health: int):
	if new_health <= 0:
		health = 0
		is_dead = true
	elif new_health > max_health:
		health = max_health
	else:
		health = new_health
	health_changed.emit(health, is_dead)

func take_damage(damage: int):
	_change_health(health - damage)
	
func heal(heal: int):
	_change_health(health + heal)
