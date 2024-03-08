class_name Rush
extends Skill

@export var preparation_time: float = 0.25
@export var recovery_time: float = 0.5
@export var navigationAgent: NavigationAgent2D
@export var speed: float = 200

var target: PhysicsBody2D
var target_position: Vector2

var elapsedTime = 0.0

func start(msg:={}):
	if (!msg.target is PhysicsBody2D): return
	
	target = msg.target
	super()

func _physics_process(delta):
	if (_state == States.PREPARE):
		# Play some animation
		if (elapsedTime >= preparation_time):
			elapsedTime = 0
			collisionShape2D.set_disabled(false)
			target_position = target.global_position
			_state = States.ACTIVE
	
	if (_state == States.ACTIVE):
		# Play some animation
		var direction = owner.global_position.direction_to(navigationAgent.get_next_path_position()).normalized()
		emitter.velocity = direction * speed
		if (emitter.velocity.length() > 0):
			emitter.set_direction(direction)
		emitter.move_and_slide()
		
		if (navigationAgent.is_navigation_finished()):
			_state = States.RECOVERY
			skillactived.emit()


	if (_state == States.RECOVERY):
		collisionShape2D.set_disabled(true)
		# Play some animation
		if (elapsedTime >= recovery_time):
			elapsedTime = 0
			end()

	elapsedTime += delta
