class_name Ghost
extends Actor

@export var attack: Skill

func _on_health_changed(old_value, new_value):
	attack.cancel()
	if (new_value <= 0):
		queue_free()
