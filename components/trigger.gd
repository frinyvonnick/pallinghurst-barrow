class_name Trigger
extends Area2D

func _init():
	collision_layer = 0
	collision_mask = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body: Player):
	if (body == null): return
	Events.emit_signal('player_trigger_entered')
