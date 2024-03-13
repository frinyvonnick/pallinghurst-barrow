extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect('player_cooldown_progressed', _on_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_changed(type, old_value, new_value, max_value):
	if (type != 'dodge'): return
	var shaderMaterial:ShaderMaterial = material
	shaderMaterial.set_shader_parameter('health', new_value / max_value)
	
