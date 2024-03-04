class_name TopDownHolder
extends Node2D

@export var actor: Actor

func _physics_process(delta):
	rotation = actor.direction.angle()
