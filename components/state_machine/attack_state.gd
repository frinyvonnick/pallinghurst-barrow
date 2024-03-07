class_name AttackState
extends State

var skill: Skill

func enter(msg:= {}):
	if !msg.has('skill'):
		# Maybe should throw an error to help dev
		return _transition_to_idle()
	super()
	skill = msg.get('skill')
	# Don't stuck enemy until recovery
	if (skill.is_recovering()): 
		return _transition_to_idle()
	skill.start()

# Don't stuck enemy until recovery
func _on_skillactived():
	if (active == false):
		return
	_transition_to_idle()
	
func _on_skillended():
	if (active == false):
		return
	_transition_to_idle()

func _transition_to_idle():
	state_machine.transition_to('idle_state')
