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
	if ("target" in msg): 
		animation_name = _get_animation_name(emitter.global_position.direction_to(msg.target.global_position))
	else:
		animation_name = _get_animation_name(null)
		
func _get_animation_name(pDirection):
	var direction = pDirection
	if (direction == null):
		direction = emitter.direction
	
	var animation = "attack"
	if (direction.x < 0):
		animation += "Left"
	elif (direction.x > 0):
		animation += "Right"
	elif (direction.y < 0):
		animation += "Up"	
	elif (direction.y > 0):
		animation += "Down"
	return animation
	
func activate():
	_state = States.ACTIVE
	emitter.topDownMovement.skip_animation = true
	emitter.animationPlayer.play(animation_name)
	await emitter.animationPlayer.animation_finished
	emitter.topDownMovement.skip_animation = false
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
