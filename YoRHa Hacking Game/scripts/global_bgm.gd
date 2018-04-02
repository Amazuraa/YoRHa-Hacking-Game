#global_bgm (background music)
extends Node

var bgm
onready var music_player = get_node("music_player")
var music_path
var music_level

var death_state = false
var death_state_prev = false
var death_state_next = false

var finish_state = false
var finish_state_prev = false
var finish_state_next = false

var min_volume = 0.1
var max_volume = 8
var current_volume

var music_3c_phase = "first"

func _ready():
	pass

func play(level):
	path(level)
	bgm = load(music_path)
	music_player.set_stream(bgm)
	music_player.set_volume_db(min_volume)
	music_player.play(0)
	set_fixed_process(true)
	pass

func path(w_level):
	if w_level == "level1":
		music_path = "res://sound/bgm/Amusement_Park.ogg"
		music_level = "level1"
	elif w_level == "level2":
		music_path = "res://sound/bgm/Wretched_Weaponry.ogg"
		music_level = "level2"
	elif w_level == "level3_A":
		music_path = "res://sound/bgm/A_Beautiful_Song.ogg"
		music_level = "level3_A"
	elif w_level == "level3_B":
		music_path = "res://sound/bgm/Dark_Colossus_Kaiju.ogg"
		music_level = "level3_B"
	elif w_level == "level3_C":
		music_path = "res://sound/bgm/End_of_the_Unknown.ogg"
		music_level = "level3_C"
	elif w_level == "main_menu":
		music_path = "res://sound/bgm/Fortress_of_Lies.ogg"
		music_level = "main_menu"
	elif w_level == "credit_3c":
		music_path = "res://sound/bgm/Weight_of_the_World.ogg"
		music_level = "credit_3c"
	pass

func _fixed_process(delta):
	death_state_prev = death_state
	death_state = death_state_next
	
	finish_state_prev = finish_state
	finish_state = finish_state_next
	
	if music_level == "level1":
		if music_player.get_pos() >= 127.568:
			music_player.play(8.112)
	elif music_level == "level2":
		if music_player.get_pos() >= 167.55:
			music_player.play(17.1487)
	elif music_level == "level3_A":
		if music_player.get_pos() >= 138.336:
			music_player.play(16.87)
	elif music_level == "level3_B":
		if music_player.get_pos() >= 122:
			music_player.play(13.39)
	elif music_level == "level3_C":
		if music_player.get_pos() >= 143.50:
			music_player.play(15)
	elif music_level == "main_menu":
		if music_player.get_pos() >= 140.46511291:
			music_player.play(19.7555559)
	elif music_level == "credit_3c":
		if music_3c_phase == "first":
			if music_player.get_pos() >= 125.481:
				music_player.play(17.0631)#17.057
		elif music_3c_phase == "second":
			if music_player.get_pos() >= 203 :
				music_player.play(188.56)
		elif music_3c_phase == "third":
			pass
	elif music_level == "last":
		finish_state_next = true
	
	###======================================================
	
	if death_state == false:
		current_volume = music_player.get_volume_db()
		if current_volume <= max_volume:
			current_volume += (1 * delta)
		music_player.set_volume_db(current_volume)
	
	elif death_state == true:
		current_volume = music_player.get_volume_db()
		if current_volume >= min_volume:
			current_volume -= (1.5 * delta)
		music_player.set_volume_db(current_volume)
	
	###======================================================
	
	if finish_state == true:
		current_volume = music_player.get_volume_db()
		if current_volume >= -50 :
			current_volume -= (10 * delta)
		else:
			if music_player.is_playing() == true:
				music_player.stop()
			elif music_player.is_playing() == false:
				pass
		music_player.set_volume_db(current_volume)
	
	elif finish_state == false:
		pass
	
	###======================================================
	pass
