class_name IdleState
extends State

func enter(msg:= {}):
	super()
	state_machine.sight.body_entered.connect(_on_body_entered)
	
	# Check if player is still here
	if (state_machine.sight.has_overlapping_bodies() == false):
		return
	var comparator = func(body): return body is Player
	var bodies = state_machine.sight.get_overlapping_bodies().filter(comparator)
	if (bodies.size() > 0):
		_transition_to_seek(bodies[0])
	
func physics_update(delta):
	actor.velocity = Vector2.ZERO
		
func exit():
	state_machine.sight.body_entered.disconnect(_on_body_entered)

func _on_body_entered(body):
	if (active == false):
		return
	if (body is Player):
		_transition_to_seek(body)

func _transition_to_seek(body):
	state_machine.transition_to('seek_state', {target = body})
