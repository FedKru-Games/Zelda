class_name HitBox extends Area2D

@onready var _collision: CollisionShape2D = get_node("CollisionShape2D")

var damage: int = 0
 
var owner_entity: Node = null

func disable():
	_collision.disabled = true
	
func enable():
	_collision.disabled = false

func set_shape(shape):
	_collision.shape = shape
