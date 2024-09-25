class_name HurtBox extends Area2D

func _on_area_entered(hitbox: HitBox):
	owner.take_damage(hitbox.damage)
