#level text control
extends Control

### text hacking 
var main_text 
var main_text_backup = ""
var main_text_total = 0
var main_text_node
var main_text_node_path = ""
var type_stat = false
var type_count = 0

### anim
onready var anim = get_node("anim")
export var anim_count = 1
var anim_name = ""
export var anim_count_max = 17

### decoration text
var main_text_dec = ". . ."
var main_text_backup_dec = ". . ."
var main_text_total_dec = main_text_dec.length()
var main_text_node_dec
var main_text_node_path_dec = "text_hacking_container/text2_dec"
var type_stat_dec = null
var type_count_dec = 0

### info text
export var info_txt = ""
var main_text_info
var main_text_backup_info 
var main_text_total_info
var main_text_node_info
var main_text_node_path_info = "info"
var type_stat_info = false
var type_count_info = 0

export var level_clear = false
export var which_level = ""
export var level2A = false
export var level2B = false

export var which_typing = 0

export (NodePath) var scene_changer_path 
var scene_changer

export var console = false

func _ready():
	main_text_info = info_txt
	main_text_backup_info = info_txt
	main_text_total_info = main_text_info.length()
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	info()
	typing(delta)
	typing_decoration(delta)
	typing_info(delta)
	pass

func typing(delta):
	if type_stat == true:
		main_text_node = get_node(main_text_node_path)
		main_text_node.show()
		type_count += ((2.0*delta)*17.5)
		
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

func typing_info(delta):
	if type_stat_info == true:
		main_text_node_info = get_node(main_text_node_path_info)
		main_text_node_info.show()
		type_count_info += ((1.5*delta)*14.5)
		
		if type_count_info < main_text_total_info:
			main_text_node_info.set_text(main_text_info.substr(0,type_count_info))
		elif type_count_info > (main_text_total_info+1):
			main_text_node_info.set_text(main_text_backup_info)
			type_stat_info = false
		
	elif type_stat_info == false:
		type_count_info = 0
	pass

func text_play():
	main_text_node_path = "text_hacking_container/text"+str(anim_count)
	main_text_node = get_node(main_text_node_path)
	main_text = main_text_node.get_text()
	main_text_backup = main_text_node.get_text()
	main_text_total = main_text.length()
	type_stat = true
	
	if anim_count == 3:
		type_stat_dec = true
	elif anim_count == (anim_count_max-1):
		lvl_clear()
		type_stat_info = true
		
		if console == true:
			scene_changer.hidden = false
		elif console == false:
			pass
	pass

func lvl_clear():
	if level_clear == true:
		utils.main_node().get_node("CanvasLayer/note").typing_call(which_typing)
		utils.level_status(which_level, "clear")
		#utils.read_save_and_apply()
	elif level_clear == false:
		pass
	pass

func info():
	if scene_changer_path != null:
		scene_changer = get_node(scene_changer_path)
	elif scene_changer_path == null:
		pass
	
	
	if which_level == "level1":
		if utils.level1_clear == true:
			type_stat_info = true
			scene_changer.hidden = false
		else:
			pass
	
	###=================================================
	
	elif level2A == true or level2B == true:
	
		if utils.level2B_clear == true or utils.level2A_clear == true:
			info_txt = "UNLOCKED"
			type_stat_info = true
			scene_changer.hidden = false
		elif utils.level2B_clear == false:
			pass
		
		main_text_info = info_txt
		main_text_backup_info = info_txt
		main_text_total_info = main_text_info.length()
		
	###=================================================
	
	elif which_level == "level3A":
		if utils.level3A_clear == true:
			info_txt = "UNLOCKED"
			type_stat_info = true
			scene_changer.hidden = false
		elif utils.level3A_clear == false:
			pass
		
		main_text_info = info_txt
		main_text_backup_info = info_txt
		main_text_total_info = main_text_info.length()
	
	###=================================================
	
	elif which_level == "level3B":
		if utils.level3B_clear == true:
			info_txt = "UNLOCKED"
			type_stat_info = true
			scene_changer.hidden = false
		elif utils.level3B_clear == false:
			pass
		
		main_text_info = info_txt
		main_text_backup_info = info_txt
		main_text_total_info = main_text_info.length()
	
	###=================================================
	
	elif which_level == "level3C":
		if utils.level3C_clear == true:
			info_txt = "UNLOCKED"
			type_stat_info = true
			scene_changer.hidden = false
		elif utils.level3C_clear == false:
			pass
		
		main_text_info = info_txt
		main_text_backup_info = info_txt
		main_text_total_info = main_text_info.length()
	
	###================================================
	
	elif which_level == "console":
		if utils.command_player == true:
			pass
		elif utils.command_player == false:
			pass
	pass
	