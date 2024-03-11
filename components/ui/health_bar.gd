extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect('health_changed', _on_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_changed(actor, old_value, new_value):
	if (!actor is Player): return
	var shaderMaterial:ShaderMaterial = material
	print(new_value, ' ', actor.health.max)
	shaderMaterial.set_shader_parameter('health', new_value / actor.health.max)
	
