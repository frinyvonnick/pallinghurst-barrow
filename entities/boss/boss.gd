class_name Boss
extends Actor

# Marquer le skills comme cancealable et boucler sur le tableau.
# Si un est actif alors on le cancel.
@export var attack: Skill

func _on_health_changed(old_value, new_value):
	attack.cancel()
	if (new_value <= 0):
		queue_free()
