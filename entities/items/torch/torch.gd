class_name Torch
extends Node2D

@export var pointLight : PointLight2D
@export var torch_energy: Vector2 = Vector2(0.5, 1)
@export var torch_scale: Vector2 = Vector2(1.2, 2)
@export var torch_color: Color = Color.html('fe9721')

var rng = RandomNumberGenerator.new()
var timeElapsed = 0
var is_off: bool = false

func _ready():
	pointLight.color = torch_color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeElapsed += delta
	if (roundf(fmod(timeElapsed,0.005)) == 0):
		var rand = rng.randfn(0.5)
		
		var targetTextureScale = remap_range(rand, 0, 1, torch_scale.x, torch_scale.y)
		pointLight.set_texture_scale(interpolate(pointLight.texture_scale, targetTextureScale, delta))
		
		var targetEnergy = remap_range(rand, 0, 1, torch_energy.x, torch_energy.y)
		pointLight.set_energy(interpolate(pointLight.energy, targetEnergy, delta))
		
	
func remap_range(value, ia, ib, oa, ob):
	return (value - ia) / (ib - ia) * (ob - oa) + oa

func turn_off():
	is_off = true
	pointLight.energy = 0
	
func turn_on():
	is_off = false

func interpolate(a, b, t):
	return a * (1 - t) + b * t
