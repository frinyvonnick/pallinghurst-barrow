class_name Health
extends HurtBox

signal health_changed(old_value, new_value)

@export var max: float = 100
@export var actor: Actor
@export var sensible_types: Array[AttackEvent.Types]

var health: float
var invulnerable: bool = false

func set_invulnerable(pInvulnerable: bool):
	invulnerable = pInvulnerable

func _ready():
	health = max
	Events.connect('actor_attacked', _on_wounded)
	super()

func reduce(amount):
	if (invulnerable): return
	var old_value = health
	health -= amount
	health_changed.emit(old_value, health)
		
func increase(amount):
	var old_value = health
	health += amount
	health_changed.emit(old_value, health)
		
func _on_wounded(event):
	if (event.body != actor || sensible_types.find(event.type) == -1): return
	reduce(event.damage)
