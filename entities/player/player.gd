extends Actor

@export var topDownInputProperties: TopDownInputProperties

@onready var topDownInput = $TopDownInput

func _ready():
	if topDownInputProperties:
		topDownInput.properties = topDownInputProperties
