class_name Attacker extends Node2D

@onready var hitbox: HitBox = get_node("HitBox")

var _ticker = CountDownTicker.new()

func _ready():
	hitbox.owner_entity = owner

func attack(weapon: WeaponData, direction: Vector2) -> bool:
	if _ticker.is_completed():
		rotation = atan2(direction.y, direction.x) - PI / 2
		return true
	return false


func _physics_process(delta):
	_ticker.tick(delta)
