#player_detector
extends Area2D

export (NodePath) var first_enemy_to_spawn
var first_target

export (NodePath) var down_block_to_spawn
var second_target

export (NodePath) var up_block_to_spawn
var third_target

export (NodePath) var left_block_to_spawn
var forth_target

export (NodePath) var right_block_to_spawn
var fifth_target

export var set_to = false

var spawn_state = false

func _ready():
	self.connect("body_enter", self, "_on_body_enter")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if spawn_state == false:
		pass
	elif spawn_state == true:
		if first_enemy_to_spawn != null:
			first_target = get_node(first_enemy_to_spawn)
			first_target.start_count = set_to
		elif first_enemy_to_spawn == null:
			first_target = null
		
		if down_block_to_spawn != null:
			second_target = get_node(down_block_to_spawn)
			second_target.start_count = set_to
		elif down_block_to_spawn == null:
			second_target = null
		
		if up_block_to_spawn != null:
			third_target = get_node(up_block_to_spawn)
			third_target.start_count = set_to
		elif up_block_to_spawn == null:
			third_target = null
		
		if left_block_to_spawn != null:
			forth_target = get_node(left_block_to_spawn)
			forth_target.start_count = set_to
		elif left_block_to_spawn == null:
			forth_target = null
		
		if right_block_to_spawn != null:
			fifth_target = get_node(right_block_to_spawn)
			fifth_target.start_count = set_to
		elif right_block_to_spawn == null:
			fifth_target = null
		
		queue_free()
	pass

func _on_body_enter(body):
	if body.get_groups().has("player"):
		spawn_state = true
	pass
