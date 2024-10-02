class_name CharacterStateMachine extends StateMachine


var character: Character


@onready var states = {
	'idle': get_node("Idle"),
	'moving': get_node("Moving"),
	'running': get_node("Running"),
	'melee': get_node("Melee"),
	'dead': get_node("Dead")
}

func init(character: Character):
	self.character = character
	
	for state in states.values():
		state.init(character)
		state.state_changed.connect(_on_state_changed);
		
	set_state(states['idle'])
	
	character.health.health_changed.connect(_on_health_changed)
	character.hurtbox.damage_taken.connect(_on_damage_taken)
	
func _on_state_changed(state_name: String):
	match state_name:
		'pop': pop()
		_: set_state(states[state_name])

func _on_damage_taken(damage: int): 
	_state.on_damage_taken(damage)

func _on_health_changed(health: int, is_dead: bool):
	_state.on_health_changed(health, is_dead)
