extends Node2D

@onready var cleave: Cleave = $Cleave


# Called when the node enters the scene tree for the first time.
func _ready():
	cleave.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
