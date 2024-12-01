extends TextureProgressBar

var _health: Health

var target_value: float = 0
var target_max_value: float = 0

var target_value_weight: float = 0
var target_max_value_weight: float = 0

var _health_accuired = false

func init(health: Health):
	_health = health
	target_value = health.health
	target_max_value = health.max_health
	value = target_value
	max_value = target_max_value
	
	health.health_changed.connect(_on_health_changed)
	health.max_health_changed.connect(_on_max_health_changed)
	_on_health_changed(health.health, false)
	

func _on_health_changed(health: int, is_dead: float):
	target_value = health
	target_value_weight = 0
	
func _on_max_health_changed(max_health: int):
	target_max_value_weight = 0
	target_max_value = max_health


func _process(delta):
	if target_max_value_weight < 1:
		target_max_value_weight = clampf(target_max_value_weight + delta, 0, 1)	
		max_value = lerpf(value, target_max_value, target_max_value_weight)
		visible = !_health.is_dead and value < _health.max_health
		
	if target_value_weight < 1:
		target_value_weight = clampf(target_value_weight + delta, 0, 1)
		value = lerpf(value, target_value, target_value_weight)
		visible = !_health.is_dead and value < _health.max_health
