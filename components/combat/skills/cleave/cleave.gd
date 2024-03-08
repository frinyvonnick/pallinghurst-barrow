class_name Cleave
extends Skill

@export var speed: float = 2.0
@export var angle: float = 270.0

@export var preparation_time: float = 0.25
@export var recovery_time: float = 0.5

var targetRotation
var elapsedTime = 0.0

func _ready():
	super()
	targetRotation = deg_to_rad(angle)

func _physics_process(delta):
	if (_state == States.PREPARE):
		# Play some animation
		if (elapsedTime >= preparation_time):
			elapsedTime = 0
			collisionShape2D.set_disabled(false)
			_state = States.ACTIVE
	
	if (_state == States.ACTIVE):
		rotation = lerpf(rotation, targetRotation, speed * delta)
		if (snappedf(rotation, 0.01) >= snappedf(targetRotation, 0.01)):
			skillactived.emit()
			_state = States.RECOVERY

	if (_state == States.RECOVERY):
		collisionShape2D.set_disabled(true)
		# Play some animation
		if (elapsedTime >= recovery_time):
			elapsedTime = 0
			end()

	elapsedTime += delta
