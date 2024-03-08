class_name Torch
extends Node2D

@onready var pointLight : PointLight2D = $PointLight2D
@export var energy: Vector2 = Vector2(0.5, 1)
@export var texture_scale: Vector2 = Vector2(1.2, 2)

var rng = RandomNumberGenerator.new()
var timeElapsed = 0
var is_off: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func interpolate(a, b, t):
	return a * (1 - t) + b * t

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeElapsed += delta
	if (roundf(fmod(timeElapsed,0.005)) == 0):
		var rand = rng.randfn(0.5)
		
		var targetTextureScale = remap_range(rand, 0, 1, texture_scale.x, texture_scale.y)
		pointLight.set_texture_scale(interpolate(pointLight.texture_scale, targetTextureScale, delta))
		
		var targetEnergy = remap_range(rand, 0, 1, energy.x, energy.y)
		pointLight.set_energy(interpolate(pointLight.energy, targetEnergy, delta))
		
	
func remap_range(value, ia, ib, oa, ob):
	return (value - ia) / (ib - ia) * (ob - oa) + oa

func turn_off():
	is_off = true
	pointLight.energy = 0
	
func turn_on():
	is_off = false
