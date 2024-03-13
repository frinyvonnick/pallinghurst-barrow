extends Node2D

func _unhandled_input(event):
	if (Input.is_action_just_pressed("enter")):
		# Go to next scene
		get_tree().change_scene_to_file("res://levels/barrow_evening/barrow_day.tscn")
