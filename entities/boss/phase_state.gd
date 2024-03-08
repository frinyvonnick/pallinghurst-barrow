class_name PhaseState
extends State

func physics_update():

@export var marker: Marker2D
@export var preparation_time: float = 0.25
@export var active_time: float = 0.1
@export var recovery_time: float = 0.5

var elapsedTime = 0.0

func physics_update():
	var distance_to_marker = (marker.global_position - actor.global_position).length()
	if (distance_to_marker > 0):
		# Play some animation
		if (elapsedTime >= preparation_time):
			elapsedTime = 0
			collisionShape2D.set_disabled(false)
			_state = States.ACTIVE
	
	if (_state == States.ACTIVE):
		# Play some animation
		if (elapsedTime >= active_time):
			elapsedTime = 0
			_state = States.RECOVERY

	elapsedTime += delta
