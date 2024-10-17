class_name CharacterFinder extends Area2D

signal on_character_found(character: Node2D, relation: Fraction.Relation) 

signal on_character_lost(character: Node2D, relation: Fraction.Relation)

var character: Character

func _on_area_entered(other):
	var owner_fraction = character.fraction_id
	if other != null and 'fraction_id' in other.owner:
		on_character_found.emit(other.owner, FractionRelationDatabase.get_relation(owner_fraction, other.owner.fraction_id))


func _on_area_exited(other):
	var owner_fraction = character.fraction_id
	if other != null and 'fraction_id' in other.owner:
		on_character_lost.emit(other.owner, FractionRelationDatabase.get_relation(owner_fraction, other.owner.fraction_id))


func init(character: Character):
	self.character = character

func _ready():	
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
