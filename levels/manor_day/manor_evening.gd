extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var lines: Array = [
		{character= "Narrator", content="When the people from the manor-house picked him up next day, he was hot and cold, terribly pale from fear, and mumbling incoherently."}, 
		{character= "Doctor", content="Poor fellow! he's had a verry narrow escape indeed of a bad brain fever. I oughtn't to have exhibited Cannabis in his excited condition; or, at any rate."}, 
		{character= "Narrator", content="Late in the afternoon, Joyce come by."},
		{character= "Daughter", content="Well? So the Queen of the Barrow very nearly had you!"},
		{character= "Rodolphe", content="Yes, she nearly had me. But how did you come to know it?"},
		{character= "Daughter", content="About two by the clock, I saw the lights burn terribly bright and clear on the moor for a second and I shuddered for horror."},
		{character= "Daughter", content="Then they died down low at once, and there was moaning on the moor, cries of despair, as from a great crowd cheated, and that I knew that you were not to be the Ghost-Queen's victim."},
	]
	DialogManager.start_dialog(lines)
	await DialogManager.dialog_finished
	get_tree().change_scene_to_file("res://levels/credits/menu.tscn")
