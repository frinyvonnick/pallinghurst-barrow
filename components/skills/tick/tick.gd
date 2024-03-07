class_name Tick
extends Skill

@export var preparation_time: float = 0.25
@export var active_time: float = 0.1
@export var recovery_time: float = 0.5

var elapsedTime = 0.0

func _physics_process(delta):
	if (_state == States.PREPARE):
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

	if (_state == States.RECOVERY):
		collisionShape2D.set_disabled(true)
		# Play some animation
		if (elapsedTime >= recovery_time):
			elapsedTime = 0
			end()

	elapsedTime += delta
