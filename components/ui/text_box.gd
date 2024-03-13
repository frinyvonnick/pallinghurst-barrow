class_name TextBox
extends MarginContainer

@export var label: Label
@export var animationPlayer: AnimationPlayer

func set_text(text):
	label.text = text

func hide_text_box():
	hide()
	animationPlayer.stop()
	
func show_text_box():
	show()
	animationPlayer.play('button_blink')
