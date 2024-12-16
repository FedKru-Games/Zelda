class_name FloorItem extends CharacterBody2D

@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var usable_area: UsableArea = get_node("UsableArea")

@export var item_stack: ItemStack : set = set_item_stack

var item: ItemData

func set_item_stack(stack: ItemStack):
	item_stack = stack
	item = ItemDatabase.items[stack.item_id]
	
	await ready
	sprite.texture = item.texture
	usable_area.section_name = item.name + " x" + str(stack.quantity)
	
func _ready() -> void:
	usable_area.action_used.connect(_on_action)
	
	
func _on_action(user: Node2D, action: UsableAction):
	match action.id:
		'pickup':
			EventBus.item_picked_up.emit(user, self)
		_:
			pass
	
func _physics_process(delta: float) -> void:
	velocity -= velocity * delta * 3
	move_and_slide()
