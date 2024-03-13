extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect('boss_killed', _on_boss_killed)


func _on_boss_killed():
	get_tree().change_scene_to_file("res://levels/manor_day/manor_evening.tscn")
