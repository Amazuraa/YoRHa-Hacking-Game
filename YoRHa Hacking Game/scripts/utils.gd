#utils
extends Node

var zoom    
var zoom_prev 
var zoom_next

var level1_clear  = false
var level2A_clear = false
var level2B_clear = false
var level3A_clear = false
var level3B_clear = false
var level3C_clear = false

var creat_dir = Directory.new()
var creat_dir_path = "user://"
var creat_dir_name = "YoRHa-Data"

var scene_saver_path #= "res://YoRHa-Data/level.tscn"

var savegame = File.new() #file
var save_path #= "res://level_status.save"
var save_data = { "level1_status"    : level1_clear  ,
				  "level2A_status"   : level2A_clear ,
				  "level2B_status"   : level2B_clear ,
				  "level3A_status"   : level3A_clear ,
				  "level3B_status"   : level3B_clear ,
				  "level3C_status"   : level3C_clear  } #variable to store data

var loading_destination = ""

var debug_death = false

var command_player = false

func _ready():
	
	scene_saver_path = creat_dir_path + creat_dir_name + "/level.tscn"
	save_path = creat_dir_path + creat_dir_name + "/level_status.save"
	
	zoom_prev = Vector2(3.3 , 3.3)
	if not savegame.file_exists(save_path):
		create_save()
	
	if not creat_dir.file_exists(creat_dir_path):
		creat_dir()
	
	read_save_and_apply()
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	pass

func main_node():
	var root_node = get_tree().get_root()
	return root_node.get_child( root_node.get_child_count() - 1 )
	pass

func level_status(level,status):
	if level == "level1" and status == "clear":
		level1_clear = true
		save(level1_clear, level2A_clear, level2B_clear, level3A_clear, level3B_clear, level3C_clear)
		read_save_and_apply()
	
	elif level == "level2_A" and status == "clear":
		level2A_clear = true
		save(level1_clear, level2A_clear, level2B_clear, level3A_clear, level3B_clear, level3C_clear)
		read_save_and_apply()
	
	elif level == "level2_B" and status == "clear":
		level2B_clear = true
		save(level1_clear, level2A_clear, level2B_clear, level3A_clear, level3B_clear, level3C_clear)
		read_save_and_apply()
	
	elif level == "level3_A" and status == "clear":
		level3A_clear = true
		save(level1_clear, level2A_clear, level2B_clear, level3A_clear, level3B_clear, level3C_clear)
		read_save_and_apply()
	
	### debug 
	elif level == "level3_A" and status == "unclear":
		level3A_clear = false
		save(level1_clear, level2A_clear, level2B_clear, level3A_clear, level3B_clear, level3C_clear)
		read_save_and_apply()
	
	### debug 
	elif level == "level3_B" and status == "unclear":
		level3A_clear = false
		save(level1_clear, level2A_clear, level2B_clear, level3A_clear, level3B_clear, level3C_clear)
		read_save_and_apply()
	
	elif level == "level3_B" and status == "clear":
		level3B_clear = true
		save(level1_clear, level2A_clear, level2B_clear, level3A_clear, level3B_clear, level3C_clear)
		read_save_and_apply()
	
	elif level == "level3_C" and status == "clear":
		level3C_clear = true
		save(level1_clear, level2A_clear, level2B_clear, level3A_clear, level3B_clear, level3C_clear)
		read_save_and_apply()
	pass

func creat_dir():
	creat_dir.open(creat_dir_path)
	creat_dir.make_dir(creat_dir_name)
	pass

func create_save():
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()
	pass

func remove_save():
	#data to save
	save_data["level1_status"]   = false
	save_data["level2A_status"]  = false
	save_data["level2B_status"]  = false
	save_data["level3A_status"]  = false
	save_data["level3B_status"]  = false
	save_data["level3C_status"]  = false
	
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file
	pass

func save(level1 , level2A , level2B , level3A , level3B , level3C):    
	#data to save
	save_data["level1_status"]   = level1 
	save_data["level2A_status"]  = level2A
	save_data["level2B_status"]  = level2B
	save_data["level3A_status"]  = level3A
	save_data["level3B_status"]  = level3B
	save_data["level3C_status"]  = level3C
	
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file
	pass

func read_savegame(level1 , level2A , level2B , level3A , level3B , level3C):
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	
	var dict
	
	level1  = save_data["level1_status"]
	level2A = save_data["level2A_status"]
	level2B = save_data["level2B_status"]
	level3A = save_data["level3A_status"]
	level3B = save_data["level3B_status"]
	level3C = save_data["level3C_status"]
		
	dict = { "level1_status"   : level1  ,
			 "level2A_status"  : level2A ,
			 "level2B_status"  : level2B ,
			 "level3A_status"  : level3A ,
			 "level3B_status"  : level3B ,
			 "level3C_status"  : level3C  
			}
	
	return dict
	pass

func read_save_and_apply():
	var get_data
	var lvl1
	var lvl2A
	var lvl2B
	var lvl3A
	var lvl3B
	var lvl3C
	
	get_data = read_savegame(lvl1, lvl2A, lvl2B, lvl3A, lvl3B, lvl3C)
	level1_clear = get_data.level1_status
	level2A_clear = get_data.level2A_status
	level2B_clear = get_data.level2B_status
	level3A_clear = get_data.level3A_status
	level3B_clear = get_data.level3B_status
	level3C_clear = get_data.level3C_status
	pass