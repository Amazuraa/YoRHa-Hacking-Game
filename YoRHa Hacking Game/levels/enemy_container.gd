#level1
#enemy_container
extends Node

export var start_count = false
var total_child
export var total_enemy_child = 0
var count = 0
var child
var child_name = ""

export (NodePath) var blocks_path
var blocks

export (NodePath) var spawn_next_enemy
var next_enemy

### core shield
export var any_core_shield = false
var core_shield

### scene_saver
export (NodePath) var show_scene_saver
var scene_saver

### scene_changer
export (NodePath) var show_scene_changer1
export (NodePath) var show_scene_changer2
var scene_changer1
var scene_changer2

### spawn_block
### use this if the condition same as level3_A
export (NodePath) var down_block_to_spawn
var second_target

export (NodePath) var up_block_to_spawn
var third_target

export (NodePath) var left_block_to_spawn
var forth_target

export (NodePath) var right_block_to_spawn
var fifth_target

export var block_set_to = false
export var end_song = false
export var level_clear = false
export var which_level = ""

var sfx_core_b_tscn
var sfx_core_b_inst
onready var sfx_container = utils.main_node().get_node("sfx_container")

export var end_3c = false
export var change_3c = false

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	total_child = get_child_count()
	
	if start_count == false:
		count = 0
		child_name = ""
		child = null
	elif start_count == true:
		count += 1
		
		if count == 1:
			block_spawn()
		
		if count == (total_enemy_child+1):
			start_count = false
		else:
			child_name = "spawner_enemy" + str(count)
			child = get_node(child_name)
			child.spawn = true
	
	#=============================================
	
	if any_core_shield == true:
		if total_child == 2:
			if get_child(1):
				sfx_core_b_tscn = preload("res://scenes/sfx/sfx_enemy_core_broken.tscn")
				sfx_core_b_inst = sfx_core_b_tscn.instance()
				sfx_container.add_child(sfx_core_b_inst)
				sfx_core_b_inst.play("core_broken")
				
				core_shield = get_child(1).get_node("shield")
				core_shield.queue_free()
				any_core_shield = false
			#else:
				#any_core_shield = false
	
	#=============================================
	
	if blocks_path != null:
		blocks = get_node(blocks_path)
		if total_child == 1:
			utils.main_node().get_node("CanvasLayer/note").typing_call(0)
			blocks.queue_free()
			blocks_path = null
	else:
		blocks_path = null
	
	#=============================================
	
	if total_child == 0:
		if spawn_next_enemy != null:
			next_enemy = get_node(spawn_next_enemy)
			next_enemy.start_count = true
			self.queue_free()
		else:
			lvl_clear()
			ending_song()
			self.queue_free()
		
		if end_3c == true:
			global_bgm.music_3c_phase = "third"
		elif end_3c == false:
			pass
		
		if change_3c == true:
			utils.main_node().get_node("CanvasLayer/anim").play("scn_end")
		elif change_3c == false:
			pass
		
	
	#=============================================
	
	if show_scene_saver != null:
		scene_saver = get_node(show_scene_saver)
		if total_child == 0:
			scene_saver.hidden = false
	else:
		scene_saver = null
	
	#=============================================
	
	if show_scene_changer1 != null:
		scene_changer1 = get_node(show_scene_changer1)
		if total_child == 0:
			scene_changer1.hidden = false
	else:
		scene_changer1 = null
	
	#=============================================
	
	if show_scene_changer2 != null:
		scene_changer2 = get_node(show_scene_changer2)
		if total_child == 0:
			scene_changer2.hidden = false
	else:
		scene_changer2 = null
	
	pass

func lvl_clear():
	if level_clear == true:
		utils.main_node().get_node("CanvasLayer/note").typing_call(3)
		utils.level_status(which_level, "clear")
	elif level_clear == false:
		pass
	pass

func ending_song():
	if end_song == true:
		if global_bgm.music_player.is_playing() == true:
			global_bgm.music_level = "last"
	elif end_song == false:
		pass
	pass

func block_spawn():
	if down_block_to_spawn != null:
		second_target = get_node(down_block_to_spawn)
		second_target.start_count = block_set_to
	elif down_block_to_spawn == null:
		second_target = null
		
	if up_block_to_spawn != null:
		third_target = get_node(up_block_to_spawn)
		third_target.start_count = block_set_to
	elif up_block_to_spawn == null:
		third_target = null
		
	if left_block_to_spawn != null:
		forth_target = get_node(left_block_to_spawn)
		forth_target.start_count = block_set_to
	elif left_block_to_spawn == null:
		forth_target = null
		
	if right_block_to_spawn != null:
		fifth_target = get_node(right_block_to_spawn)
		fifth_target.start_count = block_set_to
	elif right_block_to_spawn == null:
		fifth_target = null
	pass