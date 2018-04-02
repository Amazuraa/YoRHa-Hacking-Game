#core_hit
extends AnimatedSprite

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if get_frame() >= 10:
		stop()
		queue_free()
	pass


