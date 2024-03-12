class_name TopDownDodge
extends Node

@export var actor: Actor
@export var dodge_speed: float = 250
@export var dodge_duration: float = 0.2
@export var dodge_recovering_duration: float = 2
@export var animationPlayer: AnimationPlayer

var is_dodging: bool = false
var is_recovering: bool = false
var time_elapsed: float = 0.0

func _physics_process(delta):
	if (Input.is_action_just_pressed("dodge") && !is_recovering):
		Events.emit_signal('player_dodging_started')
		animationPlayer.speed_scale = 4
		_play_dodge_animation()
		is_dodging = true
		time_elapsed = 0
		actor.health.set_invulnerable(true)
	
	if is_dodging:
		actor.velocity = actor.direction * -1 * dodge_speed
		
	if is_dodging && time_elapsed >= dodge_duration:
		is_dodging = false
		is_recovering = true
		time_elapsed = 0
		actor.health.set_invulnerable(false)
		animationPlayer.speed_scale = 1
		Events.emit_signal('player_dodging_finished')
	
	if is_recovering && time_elapsed >= dodge_recovering_duration:
		is_recovering = false
		time_elapsed = 0
	
	time_elapsed += delta

func _play_dodge_animation():
	var animation = "dodge"
	if (actor.direction.x < 0):
		animation += "Left"
	elif (actor.direction.x > 0):
		animation += "Right"
	elif (actor.direction.y < 0):
		animation += "Up"	
	elif (actor.direction.y > 0):
		animation += "Down"
	animationPlayer.play(animation)
