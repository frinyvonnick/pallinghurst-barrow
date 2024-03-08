class_name Boss
extends Actor

# Marquer le skills comme cancealable et boucler sur le tableau.
# Si un est actif alors on le cancel.
@export var attack: Skill
@export var health: Health
@export var stateMachine: StateMachine
@export var marker: Marker2D
@export var phaseState: PhaseState

@export var torchs: Array[Torch]
@export var black_arms: Array[BlackArm]

var firstThird = false
var secondThird = false

func _ready():
	super()
	phaseState.marker = marker
	phaseState.torchs = torchs
	phaseState.black_arms = black_arms

func _on_health_changed(old_value, new_value):
	if (!firstThird && new_value <= health.max / 3 * 2):
		firstThird = true
		stateMachine.transition_to('phase_state')
		
	if (!secondThird && new_value <= health.max / 3):
		secondThird = true
		stateMachine.transition_to('phase_state')
	
	if (new_value <= 0):
		# Fin de la scene
		queue_free()
