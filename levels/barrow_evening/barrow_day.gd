extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var lines: Array = [
		{content= "Bonjour !", character= "Rodolphe"}, 
		{content= "ça va ?", character= "Mother"}
	]
	DialogManager.start_dialog(lines)
	await DialogManager.dialog_finished
	get_tree().change_scene_to_file("res://levels/alley/alley.tscn")

