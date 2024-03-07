class_name BlackHand
extends Actor

@export var attack: Skill
@export var sight: Area2D

@export var stateMachine: StateMachine

func _ready():
	stateMachine.sight = sight
	super()
