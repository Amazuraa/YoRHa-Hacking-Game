#enemy_bullet1
extends Area2D

export var speed = 800
var velocity = Vector2()
var destroyed = false

onready var livetime = get_node("lifetime")

func _ready():
	livetime.connect("timeout", self, "_on_lifetime_timeout")
	self.connect("area_enter", self, "_on_area_enter")
	self.connect("body_enter", self, "_on_body_enter")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	set_pos(get_pos() + velocity * delta)
	pass

func enemy_bullet_type1():
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

func _on_area_enter( area ):
	if area.has_method("player_bullet"):
		queue_free()
	elif area.has_method("player_hit_area"):
		queue_free()
	pass

func _on_body_enter( body ):
	
	var block_A = body.get_groups().has("block_A")
	var block_B = body.get_groups().has("block_B")
	var block_C = body.get_groups().has("block_C")
	
	var floor_end = body.get_groups().has("floor_end")
	
	if body.get_groups().has("player"):
		queue_free()
		body.hit()
		
	elif block_A or block_B or block_C:
		queue_free()
		
	elif floor_end:
		queue_free()
	pass
