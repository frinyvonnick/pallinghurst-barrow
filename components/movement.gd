class_name Movement
extends Node

@export var actor: Actor

func _physics_process(delta):
	actor.move_and_slide()
