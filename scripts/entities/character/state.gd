class_name CharacterState extends State

var character: Character

func init(character: Character):
	self.character = character

func melee():
	if character.input_attack and character.holster.item is WeaponData:
		change_state('melee')
		
func on_damage_taken(damage: int):
	character.health.take_damage(damage)

func on_health_changed(health: int, is_dead: bool):
	if is_dead:
		change_state("dead")
