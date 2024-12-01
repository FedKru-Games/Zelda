class_name Blocker extends Area2D

@onready var hurtbox: HurtBox = get_node("Hurtbox")

@onready var _collision: CollisionShape2D = get_node("CollisionShape2D")

func disable():
	_collision.disabled = true
	
func enable():
	_collision.disabled = false

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox) -> void:
	if  hitbox != null and hitbox is HitBox \
	and hitbox.owner != owner and not hitbox.is_collided(self):
		hitbox.register_block(self)
