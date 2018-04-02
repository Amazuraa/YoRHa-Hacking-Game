#level1
#block_battle_container
#this block only shown when enemy still remain
extends Node

export var start_count = false
var total_child
export var total_enemy_child = 0
var count = 0
var child
var child_name = ""

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	if start_count == false:
		count = 0
		child_name = ""
		child = null
	elif start_count == true:
		count += 1
		if count == (total_enemy_child+1):
			start_count = false
		else:
			child_name = "spawner_block" + str(count)
			child = get_node(child_name)
			child.spawn = true
	
	pass

