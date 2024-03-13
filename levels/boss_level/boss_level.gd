extends Node2D

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.health.reset()
	Events.connect('boss_killed', _on_boss_killed)
	var lines: Array = [
		{character= "Savages", content= "A victim! A victim! We hold him! We have him!"}, 
		{character= "Savages", content= "See! We bring you a slave, great queen! For this is the holy night of your father, the Sun, when he turns him about on his yearly course through the stars and goes south to leave us."}, 
		{character= "Savages", content= "We bring you a slave to renew your youth. Rise! Drink his hot blood! Rise! Kill and eat him!."}, 
		{character= "Narrator", content= "The great chief turned, grinning, to one of his spectral henchmen."}, 
		{character= "Boss", content= "Give me my hammer!"}, 
		{character= "Rodolphe", content= "Mercy!"}, 
		{character= "Boss", content= "What does he say? How like birds they talk, these men, whom we get for our only victims since the years grew foolish!"},
		{character= "Boss", content= "Mu-mu-mu-moo! they say, Mu-mu-mu-moo! more like frogs than men and women!"},
		{character= "Savages", content= "Carve the flesh from his bones! Slay him! Hack him to pieces!"}, 
		{character= "Ghost", content= "Show them iron!"}, 
	]
	DialogManager.start_dialog(lines)

func _on_boss_killed():
	var lines: Array = [
		{character= "Ghost", content= "Run you fool!"},
	]
	DialogManager.start_dialog(lines)
	await DialogManager.dialog_finished
	get_tree().change_scene_to_file("res://levels/manor_day/manor_evening.tscn")
