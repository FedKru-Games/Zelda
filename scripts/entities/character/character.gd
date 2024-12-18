class_name Character extends CharacterBody2D

const blood_impact_scene = preload("res://scenes/particles/attack_blood_impact.tscn")
const block_impact_scene = preload("res://scenes/particles/attack_block_impact.tscn")

@export var data: CharacterData
@export var fraction_id: String = 'good'

@onready var health = Health.new(data.max_health)
@onready var inventory = Inventory.new(5)

@onready var character_finder:	CharacterFinder = get_node("CharacterFinder")
@onready var object_finder: ObjectFinder = get_node("ObjectFinder")
@onready var attacker: Attacker = get_node("Attacker")
@onready var holster: ItemHolster = get_node("ItemHolster")
@onready var hurtbox: HurtBox = get_node("Hurtbox")
@onready var blocker: Blocker = get_node("Blocker")

@onready var _state_machine: CharacterStateMachine = get_node("StateMachine")
@onready var _animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var _character_sprite: Sprite2D = get_node("CharacterSprite")
@onready var _health_bar: TextureProgressBar = get_node("HealthBar")

@onready var audio: CharacterAudio = get_node("Audio")

var block_cooldown = CountDownTicker.new()
var knockback: Vector2 = Vector2.ZERO
var direction = Vector2(0, 1)

var input_x = 0.0
var input_y = 0.0
var input_run = false
var input_attack = false
var input_block = false

func pickup(stack: ItemStack):
	audio.coin.play()
	inventory.add_item(stack.item_id, stack.quantity)

func animate(animation_name: String):
	_animation_player.play(animation_name)
	
func has_movement_intention() -> bool:
	return input_x != 0 || input_y != 0
	
func walk():
	apply_force(Vector2(input_x, input_y).normalized() * data.walk_speed)
	
func run():
	apply_force(Vector2(input_x, input_y).normalized() * data.run_speed)
	
func apply_force(force: Vector2):
	velocity = force

func get_direction_name() -> String:
	if direction.y < -0.5:
		return "up"
	if direction.y > 0.5:	
		return "down"
	if direction.x > 0:
		return "right"
	if direction.x < 0:
		return "left"
	return "down"

func update_direction():
	if input_x != 0 or input_y != 0:
		direction = Vector2(input_x, input_y).normalized()

func _ready():
	_character_sprite.texture = data.skin
	health.max_health = data.max_health
	health.health = data.max_health
	
	holster.init(inventory)
	character_finder.init(self)
	object_finder.init(self)
	
	_health_bar.init(health)
	_state_machine.init(self)
	
	inventory.add_item(data.default_weapon, 1)
	inventory.add_item('health_potion', 5)
