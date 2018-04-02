#hint
extends Node2D

export var delay_hide = 0
var delay_count = 0
var hide_state = true

export (NodePath) var player_parent
var path = ""
var player

var detect_player = true

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	path = str(player_parent) + "/player"
	player = get_node(path)
	
	if detect_player == false:
		pass
	elif detect_player == true:
		hide_state = false
	
	if player != null:
		set_global_pos(player.get_global_pos())
		detect_player = false
	else :
		player = utils.main_node().get_node("player_spawner")
		set_global_pos(player.get_global_pos())
	
	
	###==========================================================
	
	if hide_state == true:
		self.hide()
	elif hide_state == false:
		self.show()
		delay_count += 1
		if delay_count == delay_hide:
			hide_state = true
	pass

