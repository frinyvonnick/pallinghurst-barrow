class_name Tick
extends Skill

@export var preparation_time: float = 0.25
@export var active_time: float = 0.1
@export var recovery_time: float = 0.5

var elapsedTime = 0.0

func activate():
	collisionShape2D.set_disabled(false)
	_state = States.ACTIVE
	emitter.skip_animation = true
	emitter.animationPlayer.play('attack')
	await emitter.animationPlayer.animation_finished
	emitter.skip_animation = false
	_state = States.RECOVERY

func _physics_process(delta):
	if (_state == States.PREPARE):
		# Play some animation
		if (elapsedTime >= preparation_time):
			elapsedTime = 0
			activate()

	if (_state == States.RECOVERY):
		collisionShape2D.set_disabled(true)
		# Play some animation
		if (elapsedTime >= recovery_time):
			elapsedTime = 0
			end()

	elapsedTime += delta
