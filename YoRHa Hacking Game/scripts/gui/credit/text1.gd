#credit text2
extends Control

export (NodePath) var next_sceneP
onready var next_scene = get_node(next_sceneP)

onready var anim = utils.main_node().get_node("anim")

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if anim.is_playing() == false:
		next_scene.start_next = true
		set_fixed_process(false)
	pass

