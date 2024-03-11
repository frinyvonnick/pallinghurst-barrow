extends Node

var ui: UI

var lines: Array[String]
var current_line: int

var is_dialog_started: bool

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func setup_ui(pUi: UI):
	ui = pUi

func start_dialog(pLines):
	if (is_dialog_started): return
	
	get_tree().paused = true
	lines = pLines
	_set_text_box_text()
	var text_box: TextBox = ui.get_text_box()
	text_box.show()

func _unhandled_input(event):
	if (Input.is_action_just_pressed("interact")):
		current_line += 1
		if (current_line >= lines.size()):
			is_dialog_started = false
			var text_box: TextBox = ui.get_text_box()
			text_box.hide()
			current_line = 0
			get_tree().paused = false
		else:
			_set_text_box_text()

func _set_text_box_text():
	var text_box: TextBox = ui.get_text_box()
	text_box.set_text(lines[current_line])
	