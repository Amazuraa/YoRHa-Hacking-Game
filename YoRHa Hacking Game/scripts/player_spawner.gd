#player_spawner
extends Position2D

export (PackedScene) var player_tscn
var player_inst
onready var player_container = utils.main_node().get_node("player_container")
var player_node 

onready var animation_sprite = get_node("sprite")

export var spawn_stat = true

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	if spawn_stat == true:
		if player_container.get_child_count() == 0:
			self.show()
			spawn()
			play_anim()
		elif player_container.get_child_count() == 1:
			player_node = utils.main_node().get_node("player_container/player")
			set_pos(player_node.get_global_pos())
	elif spawn_stat == false:
		self.hide()
		pass
	
	limit_anim()
	pass

func spawn():
	player_inst = player_tscn.instance()
	player_container.add_child(player_inst)
	#player_inst.set_owner(utils.main_node())
	player_inst.set_pos(get_global_pos())
	player_inst.hide()
	player_inst.active_state_next = false
	pass

func play_anim():
	animation_sprite.set_frame(0)
	animation_sprite.play("player_spawn")
	pass

func limit_anim():
	if animation_sprite.get_frame() == 81:
		player_inst.show()
	elif animation_sprite.get_frame() >= 119:
		animation_sprite.stop()
		player_inst.active_state_next = true
		self.hide()
		animation_sprite.set_frame(0)
	pass

func spawn_stat():
	spawn_stat = true
	self.show()
	pass