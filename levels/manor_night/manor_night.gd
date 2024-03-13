extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var lines: Array = [
		{character= "Narrator", content= "How long he lay there he hardly quite knew, but the clock struck twice, and his head was aching so fiercely now that he helped himself plentifully to a second dose of the thick green mixture."},
		{character= "Narrator", content= "Rudolph heard a discret knock on his room's door."},
		{character= "Daughter", content= "Look! It began."},
		{character= "Daughter", content= "You must go."},
	]
	DialogManager.start_dialog(lines)
	await DialogManager.dialog_finished
	get_tree().change_scene_to_file("res://levels/barrow_night/barrow_day.tscn")

