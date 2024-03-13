class_name TextBox
extends BoxContainer

@export var label: Label
@export var animationPlayer: AnimationPlayer
@export var characters: Array[Control]
@export var LeftTag: Label
@export var RightTag: Label

var names = {
	'Rodolphe'= 'Rodolph Reeve',
	'Mother'= 'Mrs Bouverie-Barton',
	'Savages'= 'Savages',
	'Ghost'= 'Voice from beyond the grave',
	'Narrator'= 'Narrator',
	'Daughter'= 'Joyce',
	'Doctor'= 'Dr Porter',
	'Boss'= 'Ghost Queen'
}

func set_text(text):
	var character = text.character
	var content = text.content
	
	var comparator = func(node): return node.name == character
	var characterNode = characters.filter(comparator)
	if (characterNode.size() > 0):
		characterNode[0].show()
	
	if (character == "Rodolphe" || character == "Narrator"  || character == "Savages" || character == "Ghost"):
		LeftTag.text = names.get(character)
		LeftTag.get_parent().get_parent().show()
		RightTag.get_parent().get_parent().hide()
	else:
		RightTag.text = names.get(character)
		LeftTag.get_parent().get_parent().hide()
		RightTag.get_parent().get_parent().show()
		
		
	
	comparator = func(node): return node.name != character
	var nodesToHide = characters.filter(comparator)
	for node in nodesToHide:
		node.hide()
	
	label.text = content

func hide_text_box():
	hide()
	animationPlayer.stop()
	
func show_text_box():
	show()
	animationPlayer.play('button_blink')
