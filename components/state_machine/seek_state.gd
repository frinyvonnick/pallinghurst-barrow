class_name SeekState
extends State

@export var navigationAgent: NavigationAgent2D
@export var speed: float = 100
@export var range: float = 24
@export var skills: Array[Skill]

var time_elapsed = 0
var target: PhysicsBody2D

func enter(_msg := {}):
	if !_msg.has('target'):
		# Maybe should throw an error to help dev
		return _transition_to_idle()
	super()
	target = _msg.get('target')
	_set_target_position()
	
func exit():
	target = null
	time_elapsed = 0
	actor.velocity = Vector2.ZERO
	super()

func update(delta):
	if (time_elapsed >= 0.1):
		_set_target_position()
		time_elapsed = 0
	
	time_elapsed += delta
	
func physics_update(delta):
	var direction = owner.global_position.direction_to(navigationAgent.get_next_path_position()).normalized()
	actor.velocity = direction * speed
	if (actor.velocity.length() > 0):
		actor.set_direction(direction)
	actor.move_and_slide()
	
	_check_can_attack()

### PRIVATE METHODS ###

func _transition_to_idle():
	state_machine.transition_to('idle_state')
	
func _transition_to_attack(skill):
	state_machine.transition_to('attack_state', {skill = skill})
	
func _set_target_position():
	navigationAgent.target_position = target.global_position

func _check_can_attack():
	for skill in skills:
		if (skill.can_use(navigationAgent.target_position)):
			_transition_to_attack(skill)
