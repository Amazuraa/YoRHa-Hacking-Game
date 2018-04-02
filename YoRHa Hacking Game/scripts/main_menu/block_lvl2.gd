# level2 block_A
extends Node

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if utils.level1_clear == true:
		if get_child_count() != null:
			self.queue_free()
		elif get_child_count() == null:
			pass
	elif utils.level1_clear == false:
		pass
	pass
