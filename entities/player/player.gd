class_name Player
extends Actor

@export var swordAttack: Cleave
@export var lanternAttack: Cleave
var current_skill: Cleave

@export var attackLight: PointLight2D
@export var wanderingLight: PointLight2D
@export var wanderingLantern: Node2D
@export var topDownDodge: TopDownDodge
@export var topDownMovement: TopDownMovement
@export var topDownInput: TopDownInput
@export var topDownInputProperties: TopDownInputProperties

func _ready():
	if topDownInputProperties:
		topDownInput.properties = topDownInputProperties
	_change_skill()
	
	Events.connect('player_dodging_started', _on_dodge_started)
	Events.connect('player_dodging_finished', _on_dodge_finished)
	super()

func _physics_process(delta):
	if (Input.is_action_just_pressed("attack")):
		_start_attack()
	if (Input.is_action_just_pressed("switch_weapon")):
		_change_skill()

func _change_skill():
	if (current_skill == swordAttack):
		current_skill = lanternAttack
		
		swordAttack.process_mode = Node.PROCESS_MODE_DISABLED
		swordAttack.hide()
		lanternAttack.process_mode = Node.PROCESS_MODE_INHERIT
		lanternAttack.show()
		#_turn_on_wandering_lantern()
	else:
		current_skill = swordAttack
		
		lanternAttack.process_mode = Node.PROCESS_MODE_DISABLED
		lanternAttack.hide()
		#_turn_off_wandering_lantern()
		swordAttack.process_mode = Node.PROCESS_MODE_INHERIT
		swordAttack.show()
		

func _start_attack():
	if (current_skill.is_recovering()): return
	
	if (current_skill == lanternAttack):
		wanderingLight.hide()
		attackLight.show()
		# current_skill.rotate(deg_to_rad(-67.5))
		
	current_skill.start()
	await current_skill.skillactived

func _turn_on_wandering_lantern():
	wanderingLantern.process_mode = Node.PROCESS_MODE_INHERIT
	wanderingLantern.show()

func _turn_off_wandering_lantern():
	wanderingLantern.process_mode = Node.PROCESS_MODE_DISABLED
	wanderingLantern.hide()
	
func _end_attack():
	# attackLight.hide()
	# wanderingLight.show()
	pass

func _on_lantern_skillactivated():
	_end_attack()

func _on_health_changed(old_value, new_value):
	if (new_value <= 0 && is_inside_tree()):
		health.reset()
		get_tree().reload_current_scene()
		
func _on_dodge_started():
	topDownMovement.skip_animation = true
	
func _on_dodge_finished():
	topDownMovement.skip_animation = false
