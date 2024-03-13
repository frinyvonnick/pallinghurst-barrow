extends Label

@export var stateMachine: StateMachine

var stateName = ''

func _ready():
	stateMachine.transitioned.connect(_on_state_change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = stateName

func _on_state_change(name):
	stateName = name
