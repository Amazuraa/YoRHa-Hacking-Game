#pause main
extends Control

onready var anim = get_node("anim")
var index = 0

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	pass

func _input(event):
	if event.is_action("ui_cancel") && event.is_pressed() && !event.is_echo():
		if index == 0:
			self.show()
			index = 1
			anim.play("bip")
			get_tree().set_pause(true)
		elif index == 1:
			self.hide()
			index = 0
			anim.stop(true)
			get_tree().set_pause(false)
	pass

func _fixed_process(delta):
	pass

