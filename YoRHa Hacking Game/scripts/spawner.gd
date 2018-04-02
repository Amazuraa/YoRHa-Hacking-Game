#spawner
extends Position2D

var object_tscn
export (PackedScene) var object_tscn_up
export (PackedScene) var object_tscn_down
export (PackedScene) var object_tscn_left
export (PackedScene) var object_tscn_right
var object_inst
var object_parent
var parent_name
var spawn = false

func _ready():
	which_parent()
	spawn_object()
	
	if spawn == true:
		queue_free()
	pass

func spawn_object():
	object_inst = object_tscn.instance()
	object_inst.set_pos(Vector2(get_global_pos()))
	object_parent.add_child(object_inst)
	object_inst.set_owner(utils.main_node())
	spawn = true
	pass

func which_parent():
	parent_name = get_parent().get_name()
	object_parent = utils.main_node().get_node("block_B_container")
	
	if parent_name == "block_down_spawner":
		object_tscn = object_tscn_down
	elif parent_name == "block_up_spawner":
		object_tscn = object_tscn_up
	elif parent_name == "block_left_spawner":
		object_tscn = object_tscn_left
	elif parent_name == "block_right_spawner":
		object_tscn = object_tscn_right
	
	pass