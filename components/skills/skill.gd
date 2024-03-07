class_name Skill
extends HitBox

@export var collisionShape2D: CollisionShape2D
@export var emitter: Actor
@export var damage: float = 35.0
@export var range: float = 32.0
@export var type: AttackEvent.Types = AttackEvent.Types.PHYSICAL

signal skillended
signal skillactived

enum States {READY = 0, PREPARE = 1, ACTIVE = 2, RECOVERY = 3}
var _state : int = States.READY

var startPosition: Vector2
var startScale: Vector2
var startRotation: float
var bodiesAlreadyHit: Array[PhysicsBody2D] = []

func _ready():
	startPosition = position
	startRotation = rotation
	startScale = scale
	collisionShape2D.set_disabled(true)
	super()

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
	# TODO : Maybe a bit too harsh
	_state == States.RECOVERY
	
func handle(hurt_box):
	var body = hurt_box.owner
	if (body == emitter): return
	var event = AttackEvent.new(damage, type, body)
	Events.emit_signal('actor_attacked', event)

func reset_transform():
	position = startPosition
	rotation = startRotation
	scale = startScale

func reset(): 
	_state = States.READY
	reset_transform()
