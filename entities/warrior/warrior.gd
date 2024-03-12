class_name Warrior
extends Actor

# Marquer le skills comme cancealable et boucler sur le tableau.
# Si un est actif alors on le cancel.
var attack: Skill
@export var skills: Array[Skill]
@export var seek_state: SeekState
@export var weaponSprite: Sprite2D
@export var use_hammer: bool
@export var topDownMovement: TopDownMovement

func _ready():
	attack = skills[0]
	seek_state.skills = skills
	weaponSprite.frame = 0
	if (use_hammer):
		weaponSprite.frame = 2
	super()

func _on_health_changed(old_value, new_value):
	attack.cancel()
	if (new_value <= 0):
		queue_free()
