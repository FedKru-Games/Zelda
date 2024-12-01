class_name Attacker extends Node2D

@onready var hitbox: HitBox = get_node("HitBox")

var _ticker = CountDownTicker.new()

func _ready():
	hitbox.owner_entity = owner
	hitbox.disable()
	_ticker.ticker_ended.connect(_on_attack_ended)

func _on_attack_ended():
	hitbox.disable()

func attack(weapon: WeaponData, direction: Vector2):	
	hitbox.enable()
	hitbox.damage = weapon.damage
	hitbox.knockback_strength = weapon.knockback_strength
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(weapon.attack_width, weapon.attack_height)
	hitbox.set_shape(shape)
	
	hitbox.rotation = atan2(direction.y, direction.x) - PI / 2
	hitbox.position = direction * weapon.attack_height / 2
	
	_ticker.set_ticker(weapon.attack_duration)


func _physics_process(delta):
	_ticker.tick(delta)
