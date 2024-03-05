extends State

var playerSpotted = false

func update(delta):
	if (playerSpotted):
		state_machine.transition_to('seek_state')
	
func exit():
	super()
	playerSpotted = false

func _on_body_entered(body):
	if (active == false || get_tree().get_nodes_in_group("player").is_empty()):
		return
	var player = get_tree().get_nodes_in_group("player")[0]
	if (body == player):
		playerSpotted = true
