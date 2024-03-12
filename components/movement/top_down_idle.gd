class_name TopDownIdle
extends Movement

@export var animationPlayer: AnimationPlayer

func _physics_process(delta):
	var animation = "idle"
	if (actor.direction.x < 0):
		animation += "Left"
	elif (actor.direction.x > 0):
		animation += "Right"
	elif (actor.direction.y < 0):
		animation += "Up"	
	elif (actor.direction.y > 0):
		animation += "Down"
	
	if (actor.velocity.length() == 0):
		animationPlayer.play(animation)
	
	super(delta)
