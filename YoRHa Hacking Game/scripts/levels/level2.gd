#level2
#main script of level 2
extends Node2D

func _ready():
	utils.debug_death = false
	global_bgm.finish_state_next = false
	global_bgm.death_state_next = false
	if global_bgm.music_player.is_playing() == true:
		pass
	elif global_bgm.music_player.is_playing() == false:
		global_bgm.play("level2")
	
	set_process(true)
	pass

func _process(delta):
	get_node("CanvasLayer/note").typing_call(1)
	first_save_point()
	pass

func first_save_point():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save(utils.scene_saver_path, packed_scene)
	set_process(false)
	pass


