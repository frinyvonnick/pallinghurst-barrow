class_name SeekState
extends State

@export var navigationAgent: NavigationAgent2D
@export var speed: float = 100
@export var distance_target: float = 10
@export var skills: Array[Skill]

var time_elapsed = 0
var target: PhysicsBody2D

func enter(_msg := {}):
	assert(_msg.target)
	super()
	target = _msg.get('target')
	# sort skills by range
	navigationAgent.max_speed = speed
	skills.sort_custom(sort_skills_by_range_ascending)
	navigationAgent.velocity_computed.connect(_on_velocity_computed)
	_set_target_position()
	
func exit():
	target = null
	time_elapsed = 0
	actor.velocity = Vector2.ZERO
	navigationAgent.velocity_computed.disconnect(_on_velocity_computed)
	super()

func update(delta):
	super(delta)
	if (time_elapsed >= 0.1):
		_set_target_position()
		time_elapsed = 0
	
	time_elapsed += delta
	
func physics_update(delta):
	super(delta)
	
	var direction = owner.global_position.direction_to(navigationAgent.get_next_path_position()).normalized()
	
	if (navigationAgent.avoidance_enabled):
		# To avoid obstacles
		navigationAgent.velocity = direction * speed
	else:
		# Prevent to do micro movements to adjust position
		if (navigationAgent.distance_to_target() > distance_target):
			_on_velocity_computed(direction * speed)
		else: 
			actor.velocity = Vector2.ZERO
	
	_check_can_attack()

### PRIVATE METHODS ###

func _on_velocity_computed(safe_velocity: Vector2):
	actor.velocity = safe_velocity
	if (actor.velocity.length() > 0):
		actor.set_direction(safe_velocity.normalized())
	
	if (!"topDownMovement" in actor):
		actor.move_and_slide()

func _transition_to_idle():
	state_machine.transition_to('idle_state')
	
func _transition_to_attack(skill):
	state_machine.transition_to('attack_state', {skill = skill, target = target})

func sort_skills_by_range_ascending(a: Skill, b: Skill):
		if a.range < b.range:
			return true
		return false	

func _set_target_position():
	var direction = (actor.global_position - target.global_position).normalized()
	var shortestSkillRange = skills[0].range
	
	navigationAgent.target_position = target.global_position + (direction * (shortestSkillRange * 0.7))

func _check_can_attack():
	for skill in skills:
		if (skill.can_use(target.global_position)):
			return _transition_to_attack(skill)
