class_name Skill
extends Area2D

@onready var collisionShape2D = $CollisionShape2D
@export var emitter: Actor
@export var damage: float = 35.0
@export var range: float = 32.0

signal skillended
signal skillactived

enum States {READY = 0, PREPARE = 1, ACTIVE = 2, RECOVERY = 3}
var _state : int = States.READY

var startPosition: Vector2
var startScale: Vector2
var startRotation: float

func _ready():
	startPosition = position
	startRotation = rotation
	startScale = scale
	collisionShape2D.set_disabled(true)

func start():
	if (_state != States.READY):
		return
	_state = States.PREPARE
	
func is_recovering():
	return _state == States.RECOVERY
	
func can_use(target_position: Vector2):
	if (is_recovering()): 
		return false
	var distanceBetweenTarget = target_position - owner.global_position
	return distanceBetweenTarget.length() <= range

func end():
	if (_state != States.RECOVERY):
		return
	reset()
	skillended.emit()
	
func cancel(): 
	reset()
	skillended.emit()
	
func _on_body_entered(body): 
	if (body == emitter): return
	Events.emit_signal('actor_attacked', body, damage)

func reset(): 
	_state = States.READY
	position = startPosition
	rotation = startRotation
	scale = startScale
