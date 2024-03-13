class_name UI
extends CanvasLayer

@export var text_box: TextBox

@export var combat_ui: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogManager.setup_ui(self)

func get_text_box():
	return text_box
