extends State


# Called when the node enters the scene tree for the first time.
func enter(msg:={}):
	actor.reset_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	if (actor.global_position == actor.initial_position):
		state_machine.transition_to('idle_state')
