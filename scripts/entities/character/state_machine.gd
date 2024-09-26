class_name CharacterStateMachine extends StateMachine


var character: Character


@onready var states = {
	'idle': get_node('Idle'),
	'moving': get_node('Moving'),
	'running': get_node("Running"),
	'melee': get_node("Melee")
}

func init(character: Character):
	self.character = character
	
	for state in states.values():
		state.init(character)
		state.state_changed.connect(_on_state_changed);
		
	set_state(states['idle'])
	
func _on_state_changed(state_name: String):
	match state_name:
		'pop': pop()
		_: set_state(states[state_name])

