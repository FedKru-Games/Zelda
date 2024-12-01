class_name HurtBox extends Area2D

signal damage_taken(damage: int)

signal knockback_taken(knockback_strength: float, from: Vector2)

func _ready():
	connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox) -> void:
	if  hitbox != null and hitbox is HitBox \
	and hitbox.owner != owner and not hitbox.is_collided(self):
		damage_taken.emit(hitbox.damage)
		knockback_taken.emit(hitbox.knockback_strength, hitbox.global_position)
		hitbox.register_collision(self)
