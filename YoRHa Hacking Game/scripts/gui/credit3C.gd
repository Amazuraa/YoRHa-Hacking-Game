#credit3C
extends Node2D

onready var stream_player = get_node("CanvasLayer/stream_player")

export (PackedScene) var pause_menu_tscn
var pause_menu_inst
onready var pause_menu_container = get_node("CanvasLayer/pause_menu_container")

var music_phase = "first"

func _ready():
	utils.debug_death = false
	global_bgm.finish_state_next = false
	global_bgm.death_state_next = false
	if global_bgm.music_player.is_playing() == true:
		pass
	elif global_bgm.music_player.is_playing() == false:
		global_bgm.play("credit_3c")
	#get_tree().set_pause(true)
	#stream_player.play(0)
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	#print (global_bgm.music_3c_phase)
	#if music_phase == "first":
		#if stream_player.get_pos() >= 124.6:
			#stream_player.play(16.88)
	#elif music_phase == "second":
		#if stream_player.get_pos() >= 202.2 :
			#stream_player.play(188.56)
	#elif music_phase == "third":
		#pass
	pass

func pause():
	get_tree().set_pause(true)
	pass

func resume():
	get_tree().set_pause(false)
	pass

func to_main_menu():
	get_tree().set_pause(false)
	utils.loading_destination = "res://main_menu/main_menu.tscn"
	get_tree().change_scene("res://scenes/gui/loading.tscn")
	pass

func first_save_point():
	get_node("CanvasLayer/note").typing_call(1)
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save(utils.scene_saver_path, packed_scene)
	pass

func spawn_pause_menu():
	pause_menu_inst = pause_menu_tscn.instance()
	pause_menu_container.add_child(pause_menu_inst)
	pass

func _on_phase2_body_enter( body ):
	if body.get_groups().has("player"):
		global_bgm.music_3c_phase = "second"
		var phase_selector = get_node("music_phase/phase2")
		phase_selector.queue_free()
	pass
