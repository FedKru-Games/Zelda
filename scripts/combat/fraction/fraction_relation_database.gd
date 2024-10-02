extends Node


var items: Dictionary = {
	'evil': {
		'good': Fraction.Relation.Hostile,
		'bad': Fraction.Relation.Hostile,
	},
	'bad': {
		'good': Fraction.Relation.Hostile,
		'evil': Fraction.Relation.Hostile,
	},
	'good': {
		'evil': Fraction.Relation.Hostile,
	},
}


func get_relation(current: String, other: String) -> Fraction.Relation:
	var relations = items.get(current)
	if relations == null:
		return Fraction.Relation.Neutral
	var relation = relations.get(other, Fraction.Relation.Neutral)
	return relation
