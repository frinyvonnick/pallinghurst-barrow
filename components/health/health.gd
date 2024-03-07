class_name Health
extends Node

signal health_changed(old_value, new_value)

@export var max: float = 100
@export var actor: Actor

var health: float

func _ready():
	health = max
	Events.connect('actor_attacked', _on_wounded)

func reduce(amount):
	var old_value = health
	health -= amount
	if health <= 0:
		health_changed.emit(old_value, health)
		
func increase(amount):
	var old_value = health
	health += amount
	if health <= 0:
		health_changed.emit(old_value, health)
		
func _on_wounded(body, damage):
	if(body == actor):
		reduce(damage)
