class_name Enemy
extends Actor

@export var health: Health

func _ready():
	Events.connect('actor_attacked', _on_wounded)

func _on_health_changed(old_value, new_value):
	if (new_value <= 0):
		queue_free()
		
func _on_wounded(body, damage):
	if(body == self):
		health.reduce(damage)
