class_name CharacterState extends State

var character: Character

func init(character: Character):
	self.character = character


func melee():
	if character.input_attack and character.get_item_in_holster() is WeaponData:
		change_state('melee')
