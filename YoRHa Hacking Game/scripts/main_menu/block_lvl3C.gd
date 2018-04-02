# level3C block_A
extends Node

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if utils.level3A_clear == true and utils.level3B_clear == true:
		if get_child_count() != null:
			self.queue_free()
		elif get_child_count() == null:
			pass
	elif utils.level3A_clear == false and utils.level3B_clear == false:
		pass
	pass


