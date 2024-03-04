extends CharacterBody2D

@onready var animationPlayer = $AnimationPlayer
@onready var lanternHolder = $LanternHolder

@export var SPEED = 125.0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	var animation = "walk"
	if (direction.x < 0):
		animation += "Left"
	elif (direction.x > 0):
		animation += "Right"
	elif (direction.y < 0):
		animation += "Up"	
	elif (direction.y > 0):
		animation += "Down"
		
	velocity = direction * SPEED
	
	if (velocity.length() > 0):
		animationPlayer.play(animation)
		lanternHolder.rotation = direction.angle()
	else:
		animationPlayer.stop()

	move_and_slide()
