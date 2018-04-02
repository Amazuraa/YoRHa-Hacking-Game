# main_camera
# this camera will follow the player
extends Camera2D

export (NodePath) var player_parent
var path = ""
var player

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	path = str(player_parent) + "/player"
	player = get_node(path)
	
	if player != null:
		set_global_pos(player.get_global_pos())
	else :
		player = utils.main_node().get_node("player_spawner")
		set_global_pos(player.get_global_pos())
	pass

