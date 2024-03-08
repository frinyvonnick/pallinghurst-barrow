class_name HitBox
extends Area2D

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	area_entered.connect(_on_area_entered)
	
	# Change hitbox color
	var owner_id = shape_find_owner(0)
	var other_shape_node = shape_owner_get_owner(owner_id) as CollisionShape2D
	other_shape_node.debug_color = Color.RED
	
func handle(hurt_box: HurtBox):
	pass
	
func _on_area_entered(hurt_box: HurtBox):
	if (hurt_box == null): return
	handle(hurt_box)
