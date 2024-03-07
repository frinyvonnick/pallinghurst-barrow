class_name HurtBox
extends Area2D

func _init():
	collision_layer = 2
	collision_mask = 0
	
func _ready():
	# Change hitbox color
	var owner_id = shape_find_owner(0)
	var other_shape_node = shape_owner_get_owner(owner_id) as CollisionShape2D
	other_shape_node.debug_color = Color.GREEN
