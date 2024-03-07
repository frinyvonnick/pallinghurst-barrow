class_name Actor
extends CharacterBody2D

var direction: Vector2 = Vector2.RIGHT
var initial_position: Vector2

func _ready():
	initial_position = global_position

func set_direction(v: Vector2):
	direction = v
