class_name Root
extends Node2D

@export var path2D: Path2D

@export var color: Color = Color.html("#111111")
@export var width: int = 2
@export var anchor: Marker2D
@export var actor: Actor
@export var speed: float = 50
@export var amplitude_movement: float = 8

var curve: Curve2D
var noiseGeneratorFirstBreak: FastNoiseLite
var noiseGeneratorSecondBreak: FastNoiseLite
var timeElapsed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	curve = path2D.curve
	noiseGeneratorFirstBreak = makeNoiseGenerator()
	noiseGeneratorSecondBreak = makeNoiseGenerator()
	_determine_points(anchor.global_position, actor.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_determine_points(anchor.position, actor.position)
	curve.tessellate()
	queue_redraw()
	timeElapsed += speed * delta

func _draw():
	draw_polyline(curve.get_baked_points(), color, width, true)

func _remap_range(value, ia, ib, oa, ob):
	return (value - ia) / (ib - ia) * (ob - oa) + oa

func _determine_points(origin_position, target_position):
	var firstBreakNoise = noiseGeneratorFirstBreak.get_noise_1d(timeElapsed)
	var firstBreakAngle = _remap_range(firstBreakNoise, -1.0, 1.0, - PI / amplitude_movement, PI / amplitude_movement)
	
	var secondBreakNoise = noiseGeneratorSecondBreak.get_noise_1d(timeElapsed)
	var secondBreakAngle = _remap_range(secondBreakNoise, -1.0, 1.0, - PI / amplitude_movement, PI / amplitude_movement)
	
	curve.clear_points()
	curve.add_point(origin_position)
	var firstPoint = target_position / 4
	curve.add_point(firstPoint.rotated(firstBreakAngle))
	var secondPoint = target_position - (target_position / 4)
	curve.add_point(secondPoint.rotated(secondBreakAngle))
	curve.add_point(target_position)
	
func makeNoiseGenerator():
	var noiseGenerator = FastNoiseLite.new()
	noiseGenerator.set_noise_type(FastNoiseLite.TYPE_PERLIN)
	var seed = randf() * 1000
	noiseGenerator.set_seed(seed)
	return noiseGenerator
