extends Control

@export var character: Character
@export var pointer: Control

@onready var container: PanelContainer = get_node("ActionsContainer")
@onready var sections_layout: VBoxContainer = get_node("ActionsContainer/UseActions")

var section_scene = preload("res://scenes/ui/actions/section.tscn")
var sections: Array[ActionSection]
var section_use_callables: Array[Callable]

var pointer_idx: int = 0
var pointer_action: Button = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and pointer_action != null:
		pointer_action.pressed.emit()	
	if event.is_action_pressed("ui_next"):
		set_pointer_index(pointer_idx + 1)

func get_actions_list() -> Array[Button]:
	var buttons: Array[Button] = []
	var curr_idx = 0
	for section in sections:
		for action in section.actions.get_children():
			buttons.append(action)
	return buttons

func set_pointer_index(idx: int):
	var actions = get_actions_list()
	if actions.is_empty():
		pointer_action = null
		pointer.visible = false
		return
	var index = idx % len(actions)
	var action = actions[index]
	pointer_idx = index
	pointer_action = action
	pointer.visible = true

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
	
	await get_tree().process_frame
	
	if pointer_action == null:
		set_pointer_index(0)
	
func _on_object_lost(object: UsableArea):
	var idx = -1
	for section in sections:
		idx += 1
		if section.object == object:
			break
	if idx != -1:
		sections_layout.remove_child(sections[idx])
		sections[idx].action_used.disconnect(section_use_callables[idx])
		sections[idx].queue_free()
		sections.remove_at(idx)
		section_use_callables.remove_at(idx)
		
	if sections.is_empty():
		container.visible = false
	
	set_pointer_index(pointer_idx)

func _process(delta: float) -> void:
	if pointer_action != null:
		pointer.global_position = pointer_action.global_position \
			+ Vector2(- pointer.size.x - 1, pointer_action.size.y / 2 - pointer.size.y / 2)

func _ready() -> void:
	container.visible = false
	character.object_finder.object_found.connect(_on_object_found)
	character.object_finder.object_lost.connect(_on_object_lost)
