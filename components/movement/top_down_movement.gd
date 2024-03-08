class_name TopDownMovement
extends Movement

@export var animationPlayer: AnimationPlayer

func _physics_process(delta):
	var animation = "walk"
	if (actor.direction.x < 0):
		animation += "Left"
	elif (actor.direction.x > 0):
		animation += "Right"
	elif (actor.direction.y < 0):
		animation += "Up"	
	elif (actor.direction.y > 0):
		animation += "Down"
	
	if (actor.velocity.length() > 0):
		animationPlayer.play(animation)
	else:
		animationPlayer.stop()
	
	super(delta)
