extends Node

func _ready() -> void:
	EventBus.item_picked_up.connect(_on_item_picked_up)
	
func _on_item_picked_up(user: Node2D, item: FloorItem):
	if user is Character:
		user.pickup(item.item_stack)
		item.queue_free()
