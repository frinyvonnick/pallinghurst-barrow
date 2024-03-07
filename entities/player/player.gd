class_name Player
extends Actor

@export var topDownInputProperties: TopDownInputProperties

@onready var topDownInput = $TopDownInput
@onready var cleave = $WeaponHolder/Cleave
@export var health: Health

func _on_health_changed(old_value, new_value):
	if (new_value <= 0 && is_inside_tree()):
		get_tree().reload_current_scene()
		
func _on_wounded(body, damage):
	if(body == self):
		health.reduce(damage)

func _ready():
	if topDownInputProperties:
		topDownInput.properties = topDownInputProperties
		
	Events.connect('actor_attacked', _on_wounded)
	super()

func _physics_process(delta):
	if (Input.is_action_just_pressed("attack")):
		cleave.start()
