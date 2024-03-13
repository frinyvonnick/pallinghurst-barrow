extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var lines: Array = [
		{character= "Narrator", content= "Rudolph Reeve sat by himself on the Old Long Barrow on Pallinghurst Common." }, 
		{character= "Narrator", content= "He knew it was getting late, and he ought to have gone back long since to the manor-house to dress for dinner." }, 
		{character= "Narrator", content= "Mrs Bouverie-Barton, his hostess, was always such a stickler for punctuality." },
		{character= "Narrator", content= "He was just going to rise, however, dreading the lasting wrath of Mrs Bouverie-Barton, when of a sudden a very weird yet definite feeling caused him for one moment to pause and hesitate." }, 
		{character= "Narrator", content= "He was deeply thrilled by this strange consciousness as of something living and moving in the barrow underneath." },
		{character= "Narrator", content= "Something living and moving or was it moving and dead?" },
		{character= "Narrator", content= "With an effort he rouse himself. The sun had now long set, and Mrs Bouverie-Barton dined at 7.30 punctually." },
	]
	DialogManager.start_dialog(lines)
	await DialogManager.dialog_finished
	get_tree().change_scene_to_file("res://levels/alley/alley.tscn")

