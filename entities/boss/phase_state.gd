class_name PhaseState
extends State

@export var marker: Marker2D
@export var active_time: float = 10
@export var navigationAgent: NavigationAgent2D

@export var torchs: Array[Torch]
@export var black_arms: Array[BlackArm]

enum States {READY = 0, PREPARE = 1, ACTIVE = 2}
var _state : int = States.READY

var elapsedTime = 0.0
var speed = 100

func enter(msg:={}):
	actor.health.set_invulnerable(true)
	navigationAgent.target_position = marker.global_position
	_state = States.PREPARE
	
func exit():
	_show_torchs()
	_hide_black_arms()
	actor.health.set_invulnerable(false)
	
func physics_update(delta):
	if (_state == States.PREPARE):
		var direction = actor.global_position.direction_to(navigationAgent.get_next_path_position()).normalized()
		actor.velocity = direction * speed
		if (actor.velocity.length() > 0):
			actor.set_direction(direction)
		if (navigationAgent.distance_to_target() <= 1):
			_set_to_active()
			actor.velocity = Vector2.ZERO
	
	if (_state == States.ACTIVE):
		if (elapsedTime >= active_time):
			elapsedTime = 0
			state_machine.transition_to('idle_state')

	elapsedTime += delta

func _set_to_active():
	actor.set_direction(Vector2.DOWN)
	_hide_torchs()
	_show_black_arms()
	_state = States.ACTIVE

func _hide_torchs():
	for torch in torchs:
		torch.process_mode = Node.PROCESS_MODE_DISABLED
		torch.turn_off()
		
func _show_torchs():
	for torch in torchs:
		torch.process_mode = Node.PROCESS_MODE_INHERIT
		torch.turn_on()
		
func _hide_black_arms():
	for black_arm: BlackArm in black_arms:
		black_arm.process_mode = Node.PROCESS_MODE_DISABLED
		black_arm.hide()
		black_arm.reset()
		
func _show_black_arms():
	for black_arm in black_arms:
		black_arm.process_mode = Node.PROCESS_MODE_INHERIT
		black_arm.show()
