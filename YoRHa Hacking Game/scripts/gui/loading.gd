#loading
extends Node2D

var change_count = 0
export var change_delay = 30
var destination
var change_state = false

### small text
var main_text 
var main_text_backup = ""
var main_text_total = 0
var main_text_node
var main_text_node_path = ""
var type_stat = false
var type_count = 0

### anim
onready var anim = get_node("anim")
var anim_count = 3
var anim_name = ""
var anim_count_max = 15

### decoration text
var main_text_dec = ". . ."
var main_text_backup_dec = ". . ."
var main_text_total_dec = main_text_dec.length()
var main_text_node_dec
var main_text_node_path_dec = "Control/text2_dec"
var type_stat_dec = false
var type_count_dec = 0

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if change_state == true:
		change_count += 1
		if change_count == change_delay:
			go_to(utils.loading_destination)
	elif change_state == false:
		pass
	
	typing(delta)
	typing_decoration(delta)
	pass

func go_to(scene_path):
	get_tree().change_scene(scene_path)
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

func typing(delta):
	if type_stat == true:
		main_text_node = get_node(main_text_node_path)
		main_text_node.show()
		type_count += ((2.0*delta)*20.5)
		
		if type_count < main_text_total:
			main_text_node.set_text(main_text.substr(0,type_count)+"_")
		elif type_count > (main_text_total+1):
			main_text_node.set_text(main_text_backup)
			anim_count += 1
			if anim_count < anim_count_max:
				anim_name = "text" + str(anim_count)
				anim.play(anim_name)
			elif anim_count == anim_count_max:
				change_state = true
			type_stat = false
		
	elif type_stat == false:
		type_count = 0
	pass

func text3_play():
	main_text_node_path = "Control/text3"
	main_text = "Authentication Code : YoRHa Type-A"
	main_text_backup = "Authentication Code : YoRHa Type-A"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text4_play():
	main_text_node_path = "Control/text4"
	main_text = "Vitals : Green"
	main_text_backup = "Vitals : Green"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text5_play():
	main_text_node_path = "Control/text5"
	main_text = "Black Box Temperature : Normal"
	main_text_backup = "Black Box Temperature : Normal"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text6_play():
	main_text_node_path = "Control/text6"
	main_text = "Remaining Energy : 100%"
	main_text_backup = "Remaining Energy : 100%"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text7_play():
	main_text_node_path = "Control/text7"
	main_text = "Loding Geographic Data"
	main_text_backup = "Loding Geographic Data"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text8_play():
	main_text_node_path = "Control/text8"
	main_text = "Target Acquired"
	main_text_backup = "Target Acquired"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text9_play():
	main_text_node_path = "Control/text9"
	main_text = "Infiltration Route Lookup Complete"
	main_text_backup = "Infiltration Route Lookup Complete"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text10_play():
	main_text_node_path = "Control/text10"
	main_text = "Activating IFF"
	main_text_backup = "Activating IFF"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text11_play():
	main_text_node_path = "Control/text11"
	main_text = "Synchronizing Field of Vision"
	main_text_backup = "Synchronizing Field of Vision"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text12_play():
	main_text_node_path = "Control/text12"
	main_text = "Connecting Nerves"
	main_text_backup = "Connecting Nerves"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text13_play():
	main_text_node_path = "Control/text13"
	main_text = "Synchronizing Rate : 100%"
	main_text_backup = "Synchronizing Rate : 100%"
	main_text_total = main_text.length()
	type_stat = true
	pass

func text14_play():
	main_text_node_path = "Control/text14"
	main_text = "Hacking Device Activation Complete"
	main_text_backup = "Hacking Device Activation Complete."
	main_text_total = main_text.length()
	type_stat = true
	pass