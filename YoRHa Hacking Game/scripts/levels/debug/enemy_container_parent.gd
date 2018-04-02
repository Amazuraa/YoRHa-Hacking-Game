# enemy container parent
extends Node

export (NodePath) var anim_path 
onready var anim = get_node(anim_path)

export var which_level = ""
export var level2A = false
export var level2B = false

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	is_it_clear()
	if get_children() == []:
		anim.play("text")
		set_fixed_process(false)
	pass

func is_it_clear():
	if which_level == "level1":
		if utils.level1_clear == true:
			self.queue_free()
		else:
			pass
	
	###=================================================
	
	elif level2A == true and level2B == true:
		if utils.level2A_clear == true:
			self.queue_free()
		elif utils.level2A_clear == false:
			pass
	
		if utils.level2B_clear == true:
			self.queue_free()
		elif utils.level2B_clear == false:
			pass
	
	###=================================================
	
	elif which_level == "level3_A":
		if utils.level3A_clear == true:
			self.queue_free()
		else:
			pass
	
	###=================================================
	
	elif which_level == "level3_B":
		if utils.level3B_clear == true:
			self.queue_free()
		else:
			pass
	
	###=================================================
	
	elif which_level == "level3_C":
		if utils.level3C_clear == true:
			self.queue_free()
		else:
			pass
	
	pass

