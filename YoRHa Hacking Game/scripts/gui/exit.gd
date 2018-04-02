#exit game
extends Node2D

onready var sample_player = get_node("sample_player")
onready var anim = get_node("anim")

func _ready():
	pass

func exit_game():
	OS.get_main_loop().quit()
	pass

func play_sound():
	sample_player.play("credit2")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if sample_player.is_active() == true:
		pass
	elif sample_player.is_active() == false and anim.is_playing() == false:
		exit_game()
	pass