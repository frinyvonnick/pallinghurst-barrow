class_name Player
extends Actor

@export var swordAttack: Cleave
@export var lanternAttack: Cleave
@export var attackLight: PointLight2D
@export var topDownDodge: TopDownDodge
@export var topDownMovement: TopDownMovement
@export var topDownInput: TopDownInput
@export var topDownInputProperties: TopDownInputProperties
@export var footstep_sound: AudioStreamPlayer2D
@export var attack_sound: AudioStreamPlayer2D

var current_skill: Cleave

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
	
	if (velocity.length() > 0 && !footstep_sound.playing):
		footstep_sound.play()
		
	if (velocity.length() == 0 && footstep_sound.playing):
		footstep_sound.stop()

func _change_skill():
	if (current_skill == swordAttack):
		current_skill = lanternAttack
		Events.emit_signal('player_weapon_changed', 'lantern')
		
		swordAttack.process_mode = Node.PROCESS_MODE_DISABLED
		swordAttack.hide()
		lanternAttack.process_mode = Node.PROCESS_MODE_INHERIT
		lanternAttack.show()
	else:
		current_skill = swordAttack
		Events.emit_signal('player_weapon_changed', 'sword')
		
		lanternAttack.process_mode = Node.PROCESS_MODE_DISABLED
		lanternAttack.hide()
		swordAttack.process_mode = Node.PROCESS_MODE_INHERIT
		swordAttack.show()
		

func _start_attack():
	if (current_skill.is_recovering()): return
	
	topDownMovement.stuck = true
	if (current_skill == lanternAttack):
		attackLight.show()
		
	current_skill.start()
	await current_skill.skillactived
	
func _end_attack():
	topDownMovement.stuck = false

func _on_lantern_skillactivated():
	_end_attack()
	
func _on_sword_skillactivated():
	_end_attack()

func _on_health_changed(old_value, new_value):
	if (new_value <= 0 && is_inside_tree()):
		health.reset()
		get_tree().reload_current_scene()
		
func _on_dodge_started():
	topDownMovement.skip_animation = true
	
func _on_dodge_finished():
	topDownMovement.skip_animation = false
	
	
func _on_attack_prepared():
	attack_sound.play()

func _on_lantern_recovery_progressed(old_value, new_value, max_value):
	Events.emit_signal('player_cooldown_progressed', 'lantern', old_value, new_value, max_value)


func _on_sword_recovery_progressed(old_value, new_value, max_value):
	Events.emit_signal('player_cooldown_progressed', 'sword', old_value, new_value, max_value)
