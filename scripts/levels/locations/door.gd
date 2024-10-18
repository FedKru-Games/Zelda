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

@export var door_position: Position
