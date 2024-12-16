class_name CharacterState extends State

signal argument_changed(state: String, value)

var character: Character

var argument = null

func init(character: Character):
	self.character = character

func change_argument(state: String, value):
	argument_changed.emit(state, value)
	
func block(delta: float):
	character.block_cooldown.tick(delta)
	if character.input_block and character.holster.item is WeaponData and character.block_cooldown.is_completed():
		change_state('block')

func melee():
	if character.input_attack and character.holster.item is WeaponData:
		change_state('melee')
		
func use_healing_item():
	if character.input_attack and character.holster.item is HealingItemData\
	and character.health.health < character.health.max_health:
		character.health.heal((character.holster.item as HealingItemData).health)
		character.inventory.remove()
		
func on_damage_taken(damage: int):
	character.health.take_damage(damage)
	if not character.health.is_dead:	
		character.audio.hurt.play()
	else:
		character.audio.dead.play()
		
	var impact = character.blood_impact_scene.instantiate()
	character.add_child(impact)
	impact.start_emitting()

func on_block_taken():
	var item = character.holster.item
	if item is WeaponData:
		character.health.take_damage(item.damage)
		var impact = character.block_impact_scene.instantiate()
		character.add_child(impact)
		impact.start_emitting()
		if not character.health.is_dead:
			on_knockback_taken(item.knockback_strength, character.attacker.position)

func on_health_changed(health: int, is_dead: bool):
	if is_dead:
		change_state("dead")

func on_knockback_taken(knockback_strength: float, from: Vector2):
	character.knockback = from.direction_to(character.position) * knockback_strength
	change_state('knockback')
	
