#start menu
extends Node2D

onready var button_start_anim = get_node("button_start/button")
onready var button_exit_anim = get_node("button_exit/button")

onready var arrow = get_node("arrow")
var index = 0

onready var sample_player = get_node("sample_player")

var change_scene = false
var change_scene2 = false

onready var anim = get_node("anim")

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	go_to_main_menu()
	exit()
	pass

func _input(event):
	if event.is_action("ui_up") && event.is_pressed() && !event.is_echo():
		if(index != 0):
			index -= 1
			
			#button_start_anim.play("selected")
			#button_exit_anim.play("reverse")
			
			sample_player.play("button_select")
			
			var x = arrow.get_pos().x
			var y = arrow.get_pos().y - 66
			arrow.set_pos(Vector2(x,y))
	
	elif event.is_action("ui_down") && event.is_pressed() && !event.is_echo():
		if(index != 1):
			index += 1
			
			#button_start_anim.play("reverse")
			#button_exit_anim.play("selected")
			
			sample_player.play("button_select")
			
			var x = arrow.get_pos().x
			var y = arrow.get_pos().y + 66
			arrow.set_pos(Vector2(x,y))
	
	elif event.is_action("enter") && event.is_pressed() && !event.is_echo():
		if (index == 0):
			sample_player.play("button_enter_start")
			anim.play("enter")
		elif (index == 1):
			sample_player.play("button_enter_start")
			anim.play("exit")
	pass

func input_active():
	set_process_input(true)
	pass

func yes():
	change_scene = true
	pass

func no():
	change_scene2 = true
	pass

func go_to_main_menu():
	if change_scene == true:
		if sample_player.is_active() == false:
			utils.loading_destination = "res://main_menu/main_menu.tscn"
			get_tree().change_scene("res://scenes/gui/loading.tscn")
	elif change_scene == false:
		pass
	pass

func exit():
	if change_scene2 == true:
		if sample_player.is_active() == false:
			utils.loading_destination = "res://scenes/gui/exit.tscn"
			get_tree().change_scene("res://scenes/gui/loading_battle.tscn")
	elif change_scene2 == false:
		pass
	pass