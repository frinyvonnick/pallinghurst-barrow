extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var lines: Array[String] = ["Bonjour !", "ça va ?"]
	DialogManager.start_dialog(lines)
