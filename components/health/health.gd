class_name Health
extends Node

signal health_changed(old_value, new_value)

@export var max: float = 100

var health: float

func _ready():
	health = max

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
