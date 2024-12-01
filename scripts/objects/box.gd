extends StaticBody2D

@onready var hurtbox: HurtBox = get_node("HurtBox")
@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var collision: CollisionShape2D = get_node("CollisionShape2D")

var _is_broken = false

func _ready() -> void:
	hurtbox.damage_taken.connect(
		func(damage):
			if not _is_broken:
				_is_broken = true
				sprite.visible = false
				collision.set_deferred("disabled", true)
	)
