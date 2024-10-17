class_name EnemySpawnPoint extends SpawnPoint

@export var fraction_id: String = 'evil'

func spawn():
	var characters = CharacterDatabase.characters[fraction_id]
	var character_data = characters[randi_range(0, len(characters) - 1)]
	var controller = preload("res://scenes/entities/character/enemy_controller.tscn").instantiate() as EnemyController
	var character = controller.get_character_node()
	character.global_position = global_position
	character.data = character_data
	character.fraction_id = fraction_id
	add_child(controller)
	
