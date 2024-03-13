class_name BlackHand
extends Actor

@export var attack: Skill
@export var sight: Area2D
@export var sprite: Sprite2D
@export var stateMachine: StateMachine

var skip_animation = false

func _ready():
	stateMachine.sight = sight
	super()
	Events.connect('actor_attacked', _on_wounded)

func _physics_process(delta):
	if (skip_animation): return
	if (velocity.length() > 0):
		animationPlayer.play('move')
	else: 
		animationPlayer.stop()
		
	var comparator = func(body): return body is Player
	var bodies = sight.get_overlapping_bodies().filter(comparator)
	if (bodies.size() > 0):
		sprite.rotation = global_position.angle_to_point(bodies[0].global_position)

func _on_wounded(event: AttackEvent):
	if (event.type == AttackEvent.Types.LIGHT && event.body == self):
		stateMachine.transition_to('retreat_state')

func reset():
	stateMachine.transition_to('reset_state')
