class_name HitBox extends Area2D

signal block_taken()

@onready var _collision: CollisionShape2D = get_node("CollisionShape2D")

var damage: int = 0
var knockback_strength: float = 0
 
var owner_entity: Node = null

var _collided_nodes = []

func disable():
	_collision.disabled = true
	_collided_nodes.clear()
	
func enable():
	_collision.disabled = false
	_collided_nodes.clear()

func set_shape(shape):
	_collision.shape = shape
	
func register_block(node):
	_collided_nodes.append(node)
	block_taken.emit()
	
func register_collision(node):
	_collided_nodes.append(node)
	
func is_collided(node) -> bool:
	return _collided_nodes.has(node)
	
