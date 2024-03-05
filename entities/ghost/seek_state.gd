extends State

var playerExited = false
var playerInRange = false

var time_elapsed = 0
var targetPosition = Vector2.ZERO

@export var navigationAgent: NavigationAgent2D
@export var speed: float = 100
@export var range: float = 24

func enter(_msg := {}):
	_set_target_position()

func _set_target_position():
	var player: Player = get_tree().get_nodes_in_group("player")[0]
	navigationAgent.target_position = player.global_position

func update(delta):
	if (time_elapsed >= 0.1):
		_set_target_position()
		time_elapsed = 0
	
	if (playerExited):
		state_machine.transition_to('idle_state')
		
	if (playerInRange):
		state_machine.transition_to('attack_state')
	
	time_elapsed += delta
	
func physics_update(delta):
	var direction = owner.global_position.direction_to(navigationAgent.get_next_path_position()).normalized()
	owner.velocity = direction * speed
	if (owner.velocity.length() > 0):
		owner.set_direction(direction)
		owner.move_and_slide()
	
	var distanceBetweenTarget = navigationAgent.target_position - owner.global_position
	if (distanceBetweenTarget.length() <= range):
		playerInRange = true
	else:
		playerInRange = false
	
func exit():
	playerExited = false
	playerInRange = false

func _on_body_exited(body):
	if (active == false || get_tree() == null):
		return
	var player = get_tree().get_nodes_in_group("player")[0]
	if (body == player):
		playerExited = true
