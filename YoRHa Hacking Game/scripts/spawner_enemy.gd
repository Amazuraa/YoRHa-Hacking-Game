#spawner_enemy
extends Position2D

export (PackedScene) var object_tscn
var object_inst
export (NodePath) var parent_path
onready var object_parent = get_node(parent_path)
var parent
export var spawn = false

var count = 0
export var delay = 0

onready var anim_sprite = get_node("sprite")

export var tower_spawn = false
export var tower_double = false
export var tower_degree = 0
export var tower_degree1 = 0

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	if spawn == true:
		count += 1
	elif spawn == false:
		count = 0
	
	
	if count == (delay+10):
		anim_sprite.set_frame(0)
		anim_sprite.play("enemy_spawn")
	
	
	if anim_sprite.get_frame() == 26:
		spawn_enemy()
		object_inst.active_state_next = true
	elif anim_sprite.get_frame() >= 29:
		queue_free()
	
	pass

func spawn_enemy():
	object_inst = object_tscn.instance()
	object_inst.set_pos(Vector2(get_global_pos()))
	
	if tower_spawn == true:
		if tower_double == true:
			object_inst.degree = tower_degree
			object_inst.degree1 = tower_degree1
		elif tower_double == false:
			object_inst.degree = tower_degree
	elif tower_spawn == false:
		pass
	
	object_parent.add_child(object_inst)
	object_inst.set_owner(utils.main_node())
	pass

