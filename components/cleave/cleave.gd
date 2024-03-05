class_name Cleave
extends Skill

@export var speed: float = 2.0
@export var angle: float = 270.0
@export var range: float = 100.0
@export var radius: float = 10.0

var targetRotation

func _ready():
	super()
	
	var shape = CapsuleShape2D.new()
	shape.set_height(range)
	shape.set_radius(radius)
	collisionShape2D.shape = shape
	collisionShape2D.position.x = position.x + range / 2
	targetRotation = deg_to_rad(angle)

func _physics_process(delta):
	if (onGoing):
		rotation = lerpf(rotation, targetRotation, speed * delta)
	
	# exit condition
	if (onGoing && snappedf(rotation, 0.01) >= snappedf(targetRotation, 0.01)):
		end()
