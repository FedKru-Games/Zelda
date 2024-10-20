extends Control

@export var character: Character

@onready var container: PanelContainer = get_node("ActionsContainer")
@onready var sections_layout: VBoxContainer = get_node("ActionsContainer/UseActions")

var section_scene = preload("res://scenes/ui/actions/section.tscn")
var sections: Array[ActionSection]
var section_use_callables: Array[Callable]

func _on_use_action(action: UsableAction, object: UsableArea):
	object.use(character, action)

func _on_object_found(object: UsableArea):
	var section: ActionSection = section_scene.instantiate()
	sections_layout.add_child(section)
	section.init(object)
	sections.append(section)
	
	var callable = _on_use_action.bind(object)
	section_use_callables.append(callable)
	
	section.action_used.connect(callable)
	
	container.visible = true
	
func _on_object_lost(object: UsableArea):
	var idx = -1
	for section in sections:
		idx += 1
		if section.object == object:
			break
	if idx != -1:
		sections_layout.remove_child(sections[idx])
		sections[idx].action_used.disconnect(section_use_callables[idx])
		sections.remove_at(idx)
		section_use_callables.remove_at(idx)
		
	if sections.is_empty():
		container.visible = false
		

func _ready() -> void:
	container.visible = false
	character.object_finder.object_found.connect(_on_object_found)
	character.object_finder.object_lost.connect(_on_object_lost)
