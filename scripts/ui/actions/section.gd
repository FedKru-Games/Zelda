class_name ActionSection extends VBoxContainer

var button_scene: PackedScene = preload("res://scenes/ui/actions/section_action_button.tscn")

@onready var actions: VBoxContainer = get_node("MarginContainer/Actions")
@onready var label: Label = get_node("Label")

signal action_used(action: UsableAction)

var object: UsableArea

func init(object: UsableArea):
	self.object = object
	label.text = object.section_name
	for action in object.actions:
		var button = button_scene.instantiate()
		actions.add_child(button)
		(button as Button).text = (action as UsableAction).name
		(button as Button).pressed.connect(func(): action_used.emit(action as UsableAction))
