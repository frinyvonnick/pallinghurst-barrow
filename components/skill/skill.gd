class_name Skill
extends Area2D

@onready var collisionShape2D = $CollisionShape2D
@export var emitter: Actor
@export var damage: float = 35.0

signal skillended

var onGoing: bool = false

var startPosition: Vector2
var startScale: Vector2
var startRotation: float

func _ready():
	startPosition = position
	startRotation = rotation
	startScale = scale
	collisionShape2D.set_disabled(true)

func start():
	onGoing = true
	collisionShape2D.set_disabled(false)
	
func end():
	onGoing = false
	collisionShape2D.set_disabled(true)
	skillended.emit()
	reset()
	
func _on_body_entered(body): 
	if (body == emitter): return
	Events.emit_signal('actor_attacked', body, damage)
	
func cancel():
	end()

func reset(): 
	position = startPosition
	rotation = startRotation
	scale = startScale
