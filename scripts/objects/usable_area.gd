class_name UsableArea extends Area2D

signal action_used(user: Node2D, action: UsableAction)

@export var section_name: String
@export var actions: Array[UsableAction]

func use(user: Node2D, action: UsableAction):
	action_used.emit(user, action)
	
