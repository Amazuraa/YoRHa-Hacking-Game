# debug main
extends Node2D

func _ready():
	utils.read_save_and_apply()
	utils.debug_death = true
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	pass

