class_name Player
extends Actor

@export var topDownInputProperties: TopDownInputProperties
@export var swordAttack: Skill
@export var lanternAttack: Skill
@export var health: Health

@onready var topDownInput = $TopDownInput

var current_skill: Skill

func _on_health_changed(old_value, new_value):
	if (new_value <= 0 && is_inside_tree()):
		get_tree().reload_current_scene()

func _ready():
	if topDownInputProperties:
		topDownInput.properties = topDownInputProperties
	change_skill()
	super()

func _physics_process(delta):
	if (Input.is_action_just_pressed("attack")):
		if (!current_skill.is_recovering()):
			if (current_skill == lanternAttack):
				current_skill.rotate(deg_to_rad(-67.5))
			current_skill.start()
	if (Input.is_action_just_pressed("switch_weapon")):
		change_skill()

func change_skill():
	if (current_skill == swordAttack):
		current_skill = lanternAttack
		
		swordAttack.process_mode = Node.PROCESS_MODE_DISABLED
		swordAttack.hide()
		lanternAttack.process_mode = Node.PROCESS_MODE_INHERIT
		lanternAttack.show()
	else:
		current_skill = swordAttack
		
		lanternAttack.process_mode = Node.PROCESS_MODE_DISABLED
		lanternAttack.hide()
		swordAttack.process_mode = Node.PROCESS_MODE_INHERIT
		swordAttack.show()
		
func _on_lantern_skillactived():
	current_skill.reset_transform()
