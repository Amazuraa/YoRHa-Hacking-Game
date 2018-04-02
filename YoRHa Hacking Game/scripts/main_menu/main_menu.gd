#main menu
extends Node2D

export (NodePath) var lvl1_info1
export (NodePath) var lvl1_info2
var lvl1_info1_node
var lvl1_info2_node

export (NodePath) var lvl2_info_base
export (NodePath) var lvl2_infoA
export (NodePath) var lvl2_infoB
export (NodePath) var lvl2_infoAB
var lvl2_info_base_node
var lvl2_infoA_node
var lvl2_infoB_node
var lvl2_infoAB_node

export (NodePath) var lvl3A_info1
export (NodePath) var lvl3A_info2
var lvl3A_info1_node
var lvl3A_info2_node

export (NodePath) var lvl3B_info1
export (NodePath) var lvl3B_info2
var lvl3B_info1_node
var lvl3B_info2_node

export (NodePath) var lvl3C_info1
export (NodePath) var lvl3C_info2
var lvl3C_info1_node
var lvl3C_info2_node

export (NodePath) var lvl3A_floor
var lvl3A_floor_node

export (NodePath) var lvl3B_floor
var lvl3B_floor_node

export (NodePath) var lvl3C_floor
var lvl3C_floor_node

func _ready():
	global_bgm.finish_state_next = false
	global_bgm.death_state_next = false
	if global_bgm.music_player.is_playing() == true:
		global_bgm.play("main_menu")
	elif global_bgm.music_player.is_playing() == false:
		global_bgm.play("main_menu")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	level1()
	level2()
	level3_A()
	level3_B()
	level3_C()
	pass

func level1():
	lvl1_info1_node = get_node(lvl1_info1)
	lvl1_info2_node = get_node(lvl1_info2)
	
	if utils.level1_clear == true:
		lvl1_info1_node.hide()
		lvl1_info2_node.show()
	pass

func level2():
	lvl2_info_base_node = get_node(lvl2_info_base)
	lvl2_infoA_node     = get_node(lvl2_infoA)
	lvl2_infoB_node     = get_node(lvl2_infoB)
	lvl2_infoAB_node    = get_node(lvl2_infoAB)
	
	lvl3A_floor_node = get_node(lvl3A_floor)
	lvl3B_floor_node = get_node(lvl3B_floor)
	
	if utils.level2A_clear == true and utils.level2B_clear == false:
		lvl2_info_base_node.hide()
		lvl2_infoA_node.show()
		lvl2_infoB_node.hide()
		lvl2_infoAB_node.hide()
		
		lvl3A_floor_node.show()
		lvl3B_floor_node.hide()
		
	elif utils.level2A_clear == false and utils.level2B_clear == true:
		lvl2_info_base_node.hide()
		lvl2_infoA_node.hide()
		lvl2_infoB_node.show()
		lvl2_infoAB_node.hide()
		
		lvl3A_floor_node.hide()
		lvl3B_floor_node.show()
	
	elif utils.level2A_clear == true and utils.level2B_clear == true:
		lvl2_info_base_node.hide()
		lvl2_infoA_node.hide()
		lvl2_infoB_node.hide()
		lvl2_infoAB_node.show()
		
		lvl3A_floor_node.show()
		lvl3B_floor_node.show()
	pass

func level3_A():
	lvl3A_info1_node = get_node(lvl3A_info1)
	lvl3A_info2_node = get_node(lvl3A_info2)
	
	if utils.level3A_clear == true:
		lvl3A_info1_node.hide()
		lvl3A_info2_node.show()
	pass

func level3_B():
	lvl3B_info1_node = get_node(lvl3B_info1)
	lvl3B_info2_node = get_node(lvl3B_info2)
	
	if utils.level3B_clear == true:
		lvl3B_info1_node.hide()
		lvl3B_info2_node.show()
	pass

func level3_C():
	lvl3C_floor_node = get_node(lvl3C_floor)
	
	lvl3C_info1_node = get_node(lvl3C_info1)
	lvl3C_info2_node = get_node(lvl3C_info2)
	
	if utils.level3A_clear == true and utils.level3B_clear == true:
		lvl3C_floor_node.show()
	
	if utils.level3C_clear == true:
		lvl3C_info1_node.hide()
		lvl3C_info2_node.show()
	pass