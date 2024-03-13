extends Node2D

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect('player_trigger_entered', _on_trigger_entered)
	player.health.reset()

func _on_trigger_entered():
	get_tree().change_scene_to_file("res://levels/boss_level/boss_level.tscn")
