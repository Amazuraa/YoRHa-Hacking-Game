#ending notification C death
extends Node2D

onready var arrow = get_node("arrow")
var index = 0

### text
var main_text 
var main_text_backup = ""
var main_text_total = 0
var main_text_node
var main_text_node_path = ""
var type_stat = false
var type_count = 0
var which_path = 0

### decide text
var main_text_d 
var main_text_backup_d = ""
var main_text_total_d = 0
var main_text_node_d
var main_text_node_path_d = ""
var type_stat_d = false
var type_count_d = 0
var which_path_d = 0

### decoration text
var main_text_dec = ". . ."
var main_text_backup_dec = ". . ."
var main_text_total_dec = main_text_dec.length()
var main_text_node_dec
var main_text_node_path_dec = "command_text1/text2_dec"
var type_stat_dec = null
var type_count_dec = 0

### anim
onready var anim = get_node("anim")
var anim_count = 1
var anim_name = ""
var anim_count_max = 0

var anim_count_d = 1
var anim_name_d = ""
var anim_count_max_d = 0


func _ready():
	text1_control()
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	typing(delta)
	typing_decoration(delta)
	pass

func text1_control():
	which_path = 1
	anim_count_max = 23
	anim_count = 1
	anim.play("text")
	pass

func typing(delta):
	if type_stat == true:
		main_text_node = get_node(main_text_node_path)
		main_text_node.show()
		type_count += ((2.0*delta)*25.5)
		
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

func typing_decoration(delta):
	if type_stat_dec == true:
		main_text_node_dec = get_node(main_text_node_path_dec)
		main_text_node_dec.show()
		type_count_dec += ((0.5*delta)*10.5)
		
		if type_count_dec < main_text_total_dec:
			main_text_node_dec.set_text(main_text_dec.substr(0,type_count_dec))
		elif type_count_dec > (main_text_total_dec+1):
			main_text_node_dec.set_text(main_text_backup_dec)
			if type_count_dec > (main_text_total_dec+4):
				type_stat_dec = false
		
	elif type_stat_dec == false:
		type_count_dec = 0
		type_stat_dec = true
	pass

func text_play():
	main_text_node_path = "command_text" +str(which_path)+ "/text" +str(anim_count)
	main_text_node = get_node(main_text_node_path)
	main_text = main_text_node.get_text()
	main_text_backup = main_text_node.get_text()
	main_text_total = main_text.length()
	type_stat = true
	
	if anim_count == 3:
		type_stat_dec = true
	elif anim_count == (anim_count_max-1):
		if which_path == 1:
			anim.play("change_allow")
		elif which_path == 2:
			anim.play("change_allow")
		elif which_path == 3:
			anim.play("change_denied")
	
	#print(which_path)
	pass

func change_allow():
	get_tree().change_scene("res://scenes/gui/ending_notificationC_delete.tscn")
	pass

func change_denied():
	get_tree().change_scene("res://scenes/gui/credit3C.tscn")
	pass