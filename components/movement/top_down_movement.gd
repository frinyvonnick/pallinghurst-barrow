class_name TopDownMovement
extends Movement

@export var animationPlayer: AnimationPlayer

var skip_animation: bool = false
var stuck: bool = false

func _physics_process(delta):
	animate()
	if (!stuck):
		super(delta)

func animate():
	if (skip_animation): return
	
	var animation = "walk"
	if (actor.velocity.length() > 0):
		animation = "walk"
		if (actor.direction.x < 0):
			animation += "Left"
		elif (actor.direction.x > 0):
			animation += "Right"
		elif (actor.direction.y < 0):
			animation += "Up"	
		elif (actor.direction.y > 0):
			animation += "Down"
	else:
		animation = "idle"
		if (actor.direction.x < 0):
			animation += "Left"
		elif (actor.direction.x > 0):
			animation += "Right"
		elif (actor.direction.y < 0):
			animation += "Up"	
		elif (actor.direction.y > 0):
			animation += "Down"
	
	animationPlayer.play(animation)
