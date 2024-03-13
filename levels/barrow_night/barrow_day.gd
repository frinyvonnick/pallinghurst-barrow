extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var lines: Array = [
		{character= "Narrator", content= "Rudolph groped his way on. His goal was the barrow."}, 
		{character= "Narrator", content= "As he went, speechless voices seemed to whisper unknown tongues encouragingly in his ear."}, 
		{character= "Narrator", content= "The blue light over the barrow now shone. A passage lay open through the grassy slope into a rude stone corridor."}, 
	]
	DialogManager.start_dialog(lines)
	await DialogManager.dialog_finished
	get_tree().change_scene_to_file("res://levels/cave/cave.tscn")

