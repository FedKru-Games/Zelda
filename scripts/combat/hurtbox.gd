class_name HurtBox extends Area2D

signal damage_taken(damage: int)

func _read():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if  hitbox != null and hitbox is HitBox and hitbox.owner != owner:
		owner.health.take_damage(hitbox.damage)
