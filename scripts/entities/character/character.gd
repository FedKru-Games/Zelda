class_name Character extends CharacterBody2D

@export var walk_speed = 30.0
@export var run_speed = 60.0
@export var max_health = 100
@export var skin_name = "Boy"

@onready var _state_machine: CharacterStateMachine = get_node("StateMachine")
@onready var _animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var _character_sprite: Sprite2D = get_node("Sprite2D")

var anim = AnimatedSprite2D.new()

var health = HealthSystem.new(max_health)

var direction = Vector2(0, 1)

var input_x = 0.0
var input_y = 0.0
var input_run = false

func animate(animation_name: String):
	_animation_player.play(animation_name)
	
func has_movement_intention() -> bool:
	return input_x != 0 || input_y != 0
	
func walk():
	velocity = Vector2(input_x, input_y).normalized() * walk_speed
	
func run():
	velocity = Vector2(input_x, input_y).normalized() * run_speed
	
	
func get_direction_name() -> String:
	if direction.y < 0:
		return "up"
	if direction.y > 0:	
		return "down"
	if direction.x > 0:
		return "right"
	return "left"


func _ready():
	anim.sprite_frames
	change_skin(skin_name)
	_state_machine.init(self)


func _normalize(a: float) -> float:
	return sign(a) * ceil(abs(a))

func change_skin(name: String):
	_character_sprite.texture = load('res://resources/Ninjas/Actor/Characters/' + name + '/SpriteSheet.png')

func update_direction():
	var x_dir = _normalize(input_x)
	var y_dir = _normalize(input_y)
	
	if x_dir != 0.0 || y_dir != 0.0:
		direction = Vector2(x_dir, y_dir)
