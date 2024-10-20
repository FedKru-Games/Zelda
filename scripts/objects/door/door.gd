class_name Door extends Node2D

enum Position {
	LEFT,
	RIGHT,
	TOP,
	BOTTOM
}

static func invertPosition(position: Position) -> Position:
	match position:
		Position.LEFT:
			return Position.RIGHT
		Position.RIGHT:
			return Position.LEFT
		Position.TOP:
			return Position.BOTTOM
		Position.BOTTOM:
			return Position.TOP
		_:
			return Position.LEFT
			
signal door_entered(user: Node2D)

@export var door_position: Position

@onready var door_actions: UsableArea = get_node("DoorActions")

func _on_action(user: Node2D, action: UsableAction):
	match action.id:
		'enter':
			door_entered.emit(user)
		_:
			pass

func _ready() -> void:
	door_actions.action_used.connect(_on_action)
