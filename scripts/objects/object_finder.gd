class_name ObjectFinder extends Area2D

var character: Character

signal object_found(object: UsableArea) 

signal object_lost(object: UsableArea)

func _on_area_entered(other):
	if other != null and other is UsableArea:
		object_found.emit(other)

func _on_area_exited(other):
	if other != null and other is UsableArea:
		object_lost.emit(other)
		
func init(character: Character):
	self.character = character

func _ready():	
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
