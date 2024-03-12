class_name Actor
extends CharacterBody2D

@export var health: Health
@export var animationPlayer: AnimationPlayer

var direction: Vector2 = Vector2.RIGHT
var initial_position: Vector2

func _ready():
	initial_position = global_position

func set_direction(v: Vector2):
	direction = v

func reset_position():
	global_position = initial_position
