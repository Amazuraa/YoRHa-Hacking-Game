#main menu
extends Node2D

onready var music_player = get_node("music_player")
onready var anim = get_node("anim")

###scene1
onready var tscn1_sprite = get_node("tscn1/sprite1")

###scene2
var main_text1 = ""
var main_text_backup1 = ""
var main_text_total1 = 0
var main_text_node1
var main_text_node_path1 = ""
var type_stat1 = false
var type_count1 = 0

var main_text2 = ""
var main_text_backup2 = ""
var main_text_total2 = 0
var main_text_node2
var main_text_node_path2 = ""
var type_stat2 = false
var type_count2 = 0

###scene3
onready var tscn3_sprite = get_node("CanvasLayer/tscn3/sprite")
var tscn3_play = false

###scene4
onready var tscn4_sprite = get_node("CanvasLayer/tscn4/sprite")
var tscn4_play = false

func _ready():
	music_player.play(0)
	#op1.play("scn1")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	tscn2_typing(delta)
	tscn3_process()
	tscn4_process()
	#if music_player.is_playing() == false:
		#get_tree().change_scene("res://scenes/gui/start_menu.tscn")
	pass

func play_tscn1():
	tscn1_sprite.play("godot_eyes")
	pass

func reverse_tscn1():
	tscn1_sprite.play("reverse_godot")
	pass

func tscn2_typing(delta):
	if type_stat1 == true:
		main_text_node1 = get_node(main_text_node_path1)
		main_text_node1.show()
		type_count1 += ((1.5*delta)*11.5)
		
		if type_count1 < main_text_total1: 
			main_text_node1.set_text(main_text1.substr(0,type_count1)+"_")
		elif type_count1 > (main_text_total1+1):
			main_text_node1.set_text(main_text_backup1)
			type_stat1 = false
	elif type_stat1 == false:
		type_count1 = 0
	
	###===================================================
	
	if type_stat2 == true:
		main_text_node2 = get_node(main_text_node_path2)
		main_text_node2.show()
		type_count2 += ((1.5*delta)*12.5)
		
		if type_count2 < main_text_total2: 
			main_text_node2.set_text(main_text2.substr(0,type_count2)+"_")
		elif type_count2 > (main_text_total2+1):
			main_text_node2.set_text(main_text_backup2)
			type_stat2 = false
	elif type_stat2 == false:
		type_count2 = 0
	
	pass

func tscn2_first():
	main_text_node_path1 = "tscn2/text1"
	main_text1 = "Based On"
	main_text_backup1 = "Based On"
	main_text_total1 = main_text1.length()
	type_stat1 = true
	anim.play("main2")
	pass

func tscn2_second():
	main_text_node_path2 = "tscn2/text2"
	main_text2 = "Hacking Gameplay"
	main_text_backup2 = "Hacking Gameplay"
	main_text_total2 = main_text2.length()
	type_stat2 = true
	pass

func tscn3_play():
	tscn3_play = true
	pass

func tscn3_process():
	if tscn3_play == true:
		tscn3_sprite.play("tscn3")
		if tscn3_sprite.get_frame() >= 19:
			tscn4_play()
			tscn3_sprite.hide()
			tscn3_play = false
	elif tscn3_play == false:
		pass
	pass

func tscn4_play():
	tscn4_sprite.show()
	tscn4_play = true
	pass

func tscn4_process():
	if tscn4_play == true:
		tscn4_sprite.play("tscn4")
		if tscn4_sprite.get_frame() >= 102:
			anim.play("main5")
			tscn4_play = false
	elif tscn4_play == false:
		pass
	pass

func to_start_menu():
	get_tree().change_scene("res://scenes/gui/start_menu.tscn")
	pass