class_name CharacterStateMachine extends StateMachine

var character: Character

@onready var states = {
	'idle': get_node("Idle"),
	'moving': get_node("Moving"),
	'running': get_node("Running"),
	'melee': get_node("Melee"),
	'dead': get_node("Dead"),
	'knockback': get_node("Knockback"),
	'block': get_node("Block")
}

func init(character: Character):
	self.character = character
	
	for state in states.values():
		state.init(character)
		state.state_changed.connect(_on_state_changed);
		state.argument_changed.connect(_on_knockback_taken)
		
	set_state(states['idle'])
	
	character.health.health_changed.connect(_on_health_changed)
	character.hurtbox.damage_taken.connect(_on_damage_taken)
	character.hurtbox.knockback_taken.connect(_on_knockback_taken)
	character.attacker.hitbox.block_taken.connect(_on_block_taken)

func _on_argument_changed(state: String, argument):
	states[state].argument = argument
	
func _on_state_changed(state_name: String):
	match state_name:
		'pop': pop()
		_: set_state(states[state_name])

func _on_damage_taken(damage: int):
	_state.on_damage_taken(damage)
	
func _on_block_taken():
	_state.on_block_taken()

func _on_health_changed(health: int, is_dead: bool):
	_state.on_health_changed(health, is_dead)

func _on_knockback_taken(knockback_strength: float, from: Vector2):
	_state.on_knockback_taken(knockback_strength, from)
