class_name EnemyController extends Node

@onready var character: Character = get_character_node()

var enemy_switch_ticker = CountDownTicker.new()

var target_character: Character = null

var enemies = []

func get_character_node() -> Character:
	return get_node("Character")

func _on_character_found(character: Node2D, relation: Fraction.Relation):
	if relation == Fraction.Relation.Hostile:
		enemies.append(character)
		enemy_switch_ticker.complete()
		_update_target_character()
		
func _on_character_lost(character: Node2D, relation: Fraction.Relation):
	var index = enemies.find(character)
	if index >= 0:
		enemies.remove_at(index)


func _ready():
	character.character_finder.on_character_found.connect(_on_character_found)
	character.character_finder.on_character_lost.connect(_on_character_lost)	

func _physics_process(delta):
	character.input_x = 0
	character.input_y = 0
	character.input_run = false
	character.input_attack = false
	
	_update_target_character()
	_process_target()
			
	enemy_switch_ticker.tick(delta)
	
func _update_target_character():
	if target_character != null and target_character.health.is_dead:
		target_character = null	
	if enemy_switch_ticker.is_completed():
		var distance: float = 1e9
		for enemy in enemies:
			var character_distance = character.position.distance_to(enemy.position)
			if  character_distance < distance\
				and not enemy.health.is_dead:
				distance = character_distance
				target_character = enemy
				
		enemy_switch_ticker.set_ticker(1)

func _process_target():
	if target_character != null:
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
		
