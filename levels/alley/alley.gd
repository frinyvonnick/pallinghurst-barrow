extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect('player_trigger_entered', _on_trigger_entered)
	
	var lines: Array = [
		{content= "It is getting dark. I should use my lantern. (Press R)", character= "Rodolphe"}
	]
	DialogManager.start_dialog(lines)

func _on_trigger_entered():
	get_tree().change_scene_to_file("res://levels/manor_evening/manor_evening.tscn")
