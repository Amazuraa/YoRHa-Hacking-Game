#core_shield
extends StaticBody2D

var destroyed = false

### sfx
export (PackedScene) var sfx_tscn_h
var sfx_inst_h
onready var sfx_container = utils.main_node().get_node("sfx_container")

func _ready():
	pass

func core_shield():
	return not destroyed
	pass

func hit():
	sfx_inst_h = sfx_tscn_h.instance()
	sfx_container.add_child(sfx_inst_h)
	sfx_inst_h.play("core_hit_shield")
	pass