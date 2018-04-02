# block_B
# this block will destroy if attach by player's bullets
extends StaticBody2D

export var health = 1

onready var hitted_sprite = get_node("sprite")

#explosion
export (PackedScene) var explosion_tscn
var explosion_inst
onready var explosion_container = utils.main_node().get_node("explosion_container")

func _ready():
	pass

func hit():
	hitted_sprite.set_frame(0)
	hitted_sprite.play("hit")
	health -= 1
	if health == 0:
		explode()
	pass

func explode():
	queue_free()
	explosion_inst = explosion_tscn.instance()
	explosion_container.add_child(explosion_inst)
	explosion_inst.set_pos(get_global_pos())
	explosion_inst.play("block_explosion")
	pass

