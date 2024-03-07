class_name BlackHand
extends Actor

@export var attack: Skill
@export var sight: Area2D

@export var stateMachine: StateMachine

func _ready():
	stateMachine.sight = sight
	super()
	Events.connect('actor_attacked', _on_wounded)

func _on_wounded(event: AttackEvent):
	if (event.type == AttackEvent.Types.LIGHT && event.body == self):
		stateMachine.transition_to('retreat_state')
