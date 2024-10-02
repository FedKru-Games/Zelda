extends Node

@onready var character: Character = get_node("Character")

var enemies = []

func _on_character_found(character: Node2D, relation: Fraction.Relation):
	if relation == Fraction.Relation.Hostile:
		enemies.append(character)

func _ready():
	character.character_finder.on_character_found.connect(_on_character_found)

func _physics_process(delta):
	character.input_x = 0
	character.input_y = 0
	character.input_run = false
	character.input_attack = false
		
	for target_character in enemies:
		if target_character.health.is_dead:
			continue
			
		var distance = character.position.distance_to(target_character.position)
		var angle = character.position.angle_to_point(target_character.position)
		var direction = Vector2.from_angle(angle)

		var weapon = character.holster.item
		if weapon is WeaponData:
			if distance <= (weapon as WeaponData).attack_height:
				character.input_attack = true
			else:
				character.input_x = direction.x
				character.input_y = direction.y
		
		break

