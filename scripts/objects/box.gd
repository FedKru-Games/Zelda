extends StaticBody2D

@onready var hurtbox: HurtBox = get_node("HurtBox")
@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var collision: CollisionShape2D = get_node("CollisionShape2D")
@onready var hit_player: AudioStreamPlayer2D = $HitPlayer

var floor_item_scene = preload("res://scenes/levels/objects/floor_item.tscn")

@export var items: Array[ItemStack]

var _is_broken = false

func _ready() -> void:
	hurtbox.damage_taken.connect(
		func(damage):
			if not _is_broken:
				_create_item()
				_is_broken = true
				sprite.visible = false
				collision.set_deferred("disabled", true)
				hit_player.play()
	)

func _create_item():
	for item in items:
		var floor_item: FloorItem = floor_item_scene.instantiate()
		floor_item.item_stack = item
		floor_item.position = Vector2.ZERO
		floor_item.velocity = Vector2(randf_range(-100, 100), randf_range(-100, 100))
		call_deferred("add_child", floor_item)
