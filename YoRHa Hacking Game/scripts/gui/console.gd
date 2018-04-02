#console
extends Control

onready var text_edit = get_node("TextEdit")

var hidden = true

### anim
onready var anim = get_node("anim")
var anim_count = 1
var anim_name = ""
var anim_count_max = 0

### text
var main_text 
var main_text_backup = ""
var main_text_total = 0
var main_text_node
var main_text_node_path = ""
var type_stat = false
var type_count = 0
var which_path = 0
var type_speed = 0

var parent_text_path
var parent_text_node
var hide_node_count = 0
var hide_node_state = false

onready var text5 = get_node("body_text5")

var text_code = ""

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta): 
	text_hide_proccess()
	if hidden == false:
		self.show()
		typing(delta)
		get_tree().set_pause(true)
	elif hidden == true:
		text_edit.set_text("")
		text5.show()
		self.hide()
	pass

func typing(delta):
	if type_stat == true:
		main_text_node = get_node(main_text_node_path)
		main_text_node.show()
		type_count += ((2.0*delta)*type_speed)
		
		if type_count < main_text_total:
			main_text_node.set_text(main_text.substr(0,type_count)+"_")
		elif type_count > (main_text_total+1):
			main_text_node.set_text(main_text_backup)
			anim_count += 1
			if anim_count < anim_count_max:
				anim_name = "text" #+ str(anim_count)
				anim.play(anim_name)
			type_stat = false
		
	elif type_stat == false:
		type_count = 0
	pass

func _on_TextEdit_text_entered( text ):
	if text == "AdvanceMachine":
		text5.hide()
		anim.play("text")
		which_path = 1
		anim_count_max = 18
		anim_count = 1
		type_speed = 25.5
		text_edit.set_editable(false)
		utils.command_player = true
		
	elif text == "Reset":
		text5.hide()
		anim.play("text")
		which_path = 2
		anim_count_max = 17
		anim_count = 1
		type_speed = 25.5
		text_edit.set_editable(false)
		utils.command_player = false
		
	elif text == "console_exit":
		hidden = true
		get_tree().set_pause(false)
		
	elif text == "help":
		text5.hide()
		anim.play("text")
		which_path = 4
		anim_count_max = 16
		anim_count = 1
		type_speed = 18.5
		text_edit.set_editable(false)
		utils.command_player = false
		
	elif text == "DataLost":
		text_code = text
		text5.hide()
		anim.play("text")
		which_path = 6
		anim_count_max = 17
		anim_count = 1
		type_speed = 25.5
		text_edit.set_editable(false)
		utils.remove_save()
		
	else:
		text5.hide()
		anim.play("text")
		which_path = 3
		anim_count_max = 4
		anim_count = 1
		type_speed = 25.5
		text_edit.set_editable(false)
	pass

func text_play():
	parent_text_path = "body_text" +str(which_path)
	parent_text_node
	parent_text_node = get_node(parent_text_path)
	parent_text_node.show()
	
	main_text_node_path = "body_text" +str(which_path)+ "/text" +str(anim_count)
	main_text_node = get_node(main_text_node_path)
	main_text = main_text_node.get_text()
	main_text_backup = main_text_node.get_text()
	main_text_total = main_text.length()
	type_stat = true
	
	if anim_count == (anim_count_max-1):
		anim.play("text_hide")
	pass

func text_hide():
	parent_text_node.hide()
	hide_node_state = true
	text_edit.set_text("")
	text_edit.set_editable(true)
	pass

func text_hide_proccess():
	if hide_node_state == true:
		hide_node_count += 1
		if hide_node_count < anim_count_max:
			main_text_node_path = "body_text" +str(which_path)+ "/text" +str(hide_node_count)
			main_text_node = get_node(main_text_node_path)
			main_text_node.hide()
		elif hide_node_count > anim_count_max:
			if text_code == "DataLost":
				hidden = true
				get_tree().set_pause(false)
				utils.loading_destination = "res://levels/debug.tscn"
				get_tree().change_scene("res://scenes/gui/loading.tscn")
				#get_tree().reload_current_scene()
			else:
				pass
			hide_node_state = false
		
	elif hide_node_state == false:
		hide_node_count = 0
	pass