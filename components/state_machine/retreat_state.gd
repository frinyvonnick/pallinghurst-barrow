class_name RetreatState
extends State

@export var navigationAgent: NavigationAgent2D
@export var speed: float = 100

func enter(msg:= {}):
	_set_target_position()
	
func exit():
	actor.velocity = Vector2.ZERO
	
func physics_update(delta):
	if (navigationAgent.distance_to_target() < 5):
		_transition_to_idle()
	
	var direction = owner.global_position.direction_to(navigationAgent.get_next_path_position()).normalized()
	actor.velocity = direction * speed
	if (actor.velocity.length() > 0):
		actor.set_direction(direction)
	
	if (!"topDownMovement" in actor):
		actor.move_and_slide()

func _transition_to_idle():
	state_machine.transition_to('idle_state')

func _set_target_position():
	navigationAgent.target_position = actor.initial_position
