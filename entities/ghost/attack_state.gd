extends State

@export var skill: Skill
@export var range: float = 24

func enter(msg:= {}):
	super()
	skill.start()

func _on_body_exited(body):
	if (active == false || get_tree() == null):
		return
	var player = get_tree().get_nodes_in_group("player")[0]
	if (body == player):
		state_machine.transition_to('idle_state')


func _on_skillended():
	if (active == false || get_tree() == null):
		return
	var player = get_tree().get_nodes_in_group("player")[0]
	var distanceBetweenTarget = player.global_position - owner.global_position
	if (distanceBetweenTarget.length() >= range):
		state_machine.transition_to('seek_state')
	else:
		skill.start()
