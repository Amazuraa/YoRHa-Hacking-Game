#credit_3C_delete
extends Node2D

onready var anim = get_node("anim")
onready var music_player = get_node("CanvasLayer/music_player")
var current_volume
var min_volume = -50

var end_state = false
var end_state_prev = false
var end_state_next = false

var count = 0

onready var sample_player = get_node("sample_player")
var play = false
var play_delay = 0
var next_play = false
var next_play_delay = 0

func _ready():
	anim.play("scene1")
	current_volume = music_player.get_volume_db()
	music_player.play(0)
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	end_state_prev = end_state
	end_state = end_state_next
	
	if music_player.get_pos() >= 62:
		end_state_next = true
	
	if end_state == false:
		pass
	elif end_state == true:
		current_volume -= (5*delta)
		if current_volume <= -7:
			play = true
		elif current_volume <= min_volume:
			music_player.stop()
		
		if play == true:
			play_delay += 1
			if play_delay == 1:
				anim.play("end")
				sample_player.play("credit1")
				next_play = true
		else:
			play_delay = 0
		
		if next_play == false:
			next_play_delay = 0
		elif next_play == true:
			next_play_delay += 1
			if next_play_delay == 125:
				sample_player.play("credit2")
		
		music_player.set_volume_db(current_volume)
	pass

func to_main_menu():
	get_tree().change_scene("res://scenes/gui/ending_notificationC_delete.tscn")
	pass