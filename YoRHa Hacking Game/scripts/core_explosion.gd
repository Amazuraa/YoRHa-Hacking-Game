#core_explosion
extends AnimatedSprite

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if get_frame() >= 49:
		stop()
		queue_free()
	pass

