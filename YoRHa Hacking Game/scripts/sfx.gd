# sfx
extends SamplePlayer

var which_one = ""

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if is_active() == true:
		pass
	elif is_active() == false:
		self.queue_free()
	pass