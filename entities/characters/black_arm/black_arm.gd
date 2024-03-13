class_name BlackArm
extends Node2D

@export var radius: float = 100
@export var sightCollisionShape: CollisionShape2D
@export var black_hand: BlackHand

# Called when the node enters the scene tree for the first time.
func _ready():
	setupNavigationRegion()
	var shape: CircleShape2D = sightCollisionShape.shape
	shape.set_radius(radius)
	
func setupNavigationRegion():
	var new_navigation_mesh = NavigationPolygon.new()
	var bounding_outline = generate_circle_polygon(radius * 2, 16, Vector2.ZERO)
	new_navigation_mesh.add_outline(bounding_outline)
	NavigationServer2D.bake_from_source_geometry_data(new_navigation_mesh, NavigationMeshSourceGeometryData2D.new());
	$NavigationRegion2D.navigation_polygon = new_navigation_mesh

func generate_circle_polygon(radius: float, num_sides: int, position: Vector2) -> PackedVector2Array:
	var angle_delta: float = (PI * 2) / num_sides
	var vector: Vector2 = Vector2(radius, 0)
	var polygon: PackedVector2Array

	for _i in num_sides:
		polygon.append(vector + position)
		vector = vector.rotated(angle_delta)

	return polygon

func reset():
	black_hand.reset()
