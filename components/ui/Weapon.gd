extends Node2D

var current_weapon: String = 'sword'

@onready var changerSword: Sprite2D = $ChangeWeapon/Sword
@onready var changerLantern: Sprite2D = $ChangeWeapon/Lantern

@onready var attackSword: Sprite2D = $Attack/Sword
@onready var attackLantern: Sprite2D = $Attack/Lantern

@onready var background: Sprite2D = $Attack/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect('player_weapon_changed', _on_weapon_changed)
	Events.connect('player_cooldown_progressed', _on_cooldown_progressed)

func _on_weapon_changed(weapon):
	current_weapon = weapon
	
	if current_weapon == 'lantern':
		changerLantern.hide()
		changerSword.show()
		
		attackLantern.show()
		attackSword.hide()
	else:
		changerSword.hide()
		changerLantern.show()
		
		attackLantern.hide()
		attackSword.show()
		
	var shaderMaterial:ShaderMaterial = background.material
	shaderMaterial.set_shader_parameter('health',1)

func _on_cooldown_progressed(type, old_value, new_value, max_value):
	if (type != current_weapon): return
	
	var shaderMaterial:ShaderMaterial = background.material
	shaderMaterial.set_shader_parameter('health', new_value / max_value)
