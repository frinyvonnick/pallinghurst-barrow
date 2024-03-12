class_name Cleave
extends Skill

@export var speed: float = 2.0
@export var angle: float = 270.0

@export var preparation_time: float = 0.25
@export var recovery_time: float = 0.5
var animation_name: String

var targetRotation
var elapsedTime = 0.0

func start(msg:= {}):
	super()
	animation_name = msg.animation_name
	targetRotation = deg_to_rad(angle)
	
func activate():
	_state = States.ACTIVE
	emitter.animationPlayer.play(animation_name)
	await emitter.animationPlayer.animation_finished
	skillactived.emit()
	_state = States.RECOVERY

func _physics_process(delta):
	if (_state == States.PREPARE):
		# Play some animation
		if (elapsedTime >= preparation_time):
			elapsedTime = 0
			collisionShape2D.set_disabled(false)
			activate()

	if (_state == States.RECOVERY):
		collisionShape2D.set_disabled(true)
		# Play some animation
		if (elapsedTime >= recovery_time):
			elapsedTime = 0
			end()

	elapsedTime += delta
