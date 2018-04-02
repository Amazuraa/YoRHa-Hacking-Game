#player_bullet
extends Area2D

export var speed = 800
var velocity = Vector2()
var destroyed = false

onready var lifetime = get_node("lifetime")

func _ready():
	lifetime.connect("timeout", self, "_on_lifetime_timeout")
	self.connect("body_enter", self, "_on_body_enter")
	self.connect("area_enter", self, "_on_area_enter")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	set_pos(get_pos() + velocity * delta)
	pass

func player_bullet():
	return not destroyed
	pass

func start_at(direction, pos):
	set_rot(direction)
	set_pos(pos)
	velocity = Vector2(speed , 0).rotated(direction + PI/2)
	pass

func _on_lifetime_timeout():
	queue_free()
	pass

func _on_body_enter( body ):
	
	var block_A = body.get_groups().has("block_A")
	var block_B = body.get_groups().has("block_B")
	var block_C = body.get_groups().has("block_C")
	
	var floor_end = body.get_groups().has("floor_end")
	
	if body.get_groups().has("enemy"):
		queue_free()
		body.hit()
	elif block_A or block_C:
		queue_free()
	elif block_B:
		queue_free()
		body.hit()
	elif floor_end:
		queue_free()
	elif body.get_groups().has("core_shield"):
		queue_free()
		body.hit()
	
	pass

func _on_area_enter( area ):
	if area.has_method("enemy_bullet_type1"):
		queue_free()
	pass