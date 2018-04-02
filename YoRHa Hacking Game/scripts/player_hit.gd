#player_hit
extends AnimatedSprite

var radius = 0.0
export var radius_delay = 0
onready var hit_collision = get_node("hit_area/hit_collision")
var current_radius

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	###========================================================
	
	current_radius = hit_collision.get_shape().get_radius()
	if current_radius < 235:
		radius += (radius_delay * delta)
		hit_collision.get_shape().set_radius(radius)
	elif current_radius > 235:
		hit_collision.get_shape().set_radius(12)
	
	###========================================================
	
	if get_frame() >= 39:
		stop()
		queue_free()
	
	pass
