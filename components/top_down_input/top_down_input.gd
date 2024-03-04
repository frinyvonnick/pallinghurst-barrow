class_name TopDownInput
extends Node

@export var actor: Actor
@export var properties: TopDownInputProperties

func _physics_process(delta):
	var input = Input.get_vector("left", "right", "up", "down")
	
	actor.velocity = input * properties.speed
	if (actor.velocity.length() > 0): 
		actor.set_direction(input)
		
