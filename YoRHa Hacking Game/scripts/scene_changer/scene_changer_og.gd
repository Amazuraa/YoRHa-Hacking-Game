#scene changer on game
extends Area2D

### import the input helper class
var input_states = preload("res://scripts/scene_changer/input_states.gd")

### animation sprites
onready var contact = get_node("contact")
onready var base = get_node("base")
onready var contact_loading = get_node("contact_loading")

var area 

var active_state = false
var active_state_prev = false
var active_state_next = false

var contact_button_setting = input_states.new("contact")
var contact_button = null
var contact_count = 0

export var which_level = ""
var path_level

export var hidden = false  

var change_count = 0
export var change_delay = 30
var change_state = false
var change_state_prev = false
var change_state_next = false

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	active_state_prev = active_state
	active_state = active_state_next
	
	change_state_prev = change_state
	change_state = change_state_next
	
	if hidden == true:
		self.hide()
		active_state_next = false
	elif hidden == false:
		self.show()
	
	change_statement()
	
	if contact.get_frame() >= 14:
		contact.hide()
	
	
	if active_state == true:
		contact_button = contact_button_setting.check()
		if contact_button == 2 :
			contact_count += 1
			if contact_count == 49 :
				choose_level(which_level)
				change_level(path_level)
				active_state_next = false
				
			contact_loading.set_frame(contact_count)
		
		elif contact_button == 0 :
			contact_count = 0
			contact_loading.set_frame(contact_count)
		
	elif active_state == false:
		pass
	
	pass

func choose_level(which_level):
	if which_level == "level1":
		path_level = "res://levels/level1.tscn"
	elif which_level == "level2":
		path_level = "res://levels/level2.tscn"
	elif which_level == "level3_A":
		path_level = "res://levels/level3_A.tscn"
	elif which_level == "level3_B":
		path_level = "res://levels/level3_B.tscn"
	elif which_level == "level3_C":
		path_level = "res://levels/level3_C.tscn"
	elif which_level == "main_menu":
		path_level = "res://main_menu/main_menu.tscn"
	elif which_level == "credit3_A":
		path_level = "res://scenes/gui/credit3A.tscn"
	elif which_level == "credit3_B":
		path_level = "res://scenes/gui/credit3B.tscn"
	elif which_level == "credit3_C":
		get_tree().change_scene("res://scenes/gui/ending_notificationC.tscn")
	pass

func change_level( level ):
	var level_path = level
	utils.loading_destination = level_path
	if global_bgm.music_player.is_playing() == true:
		global_bgm.music_level = "last"
	change_state_next = true
	pass

func change_statement():
	if change_state == true:
		change_count += 1
		if change_count == change_delay:
			get_tree().change_scene("res://scenes/gui/loading_battle.tscn")
	elif change_state == false:
		pass
	pass

func _on_body_enter( body ):
	if body.get_groups().has("player"):
		contact.show()
		contact.set_frame(0)
		contact.play("contact")
		
		base.set_frame(0)
		base.play("touched")
		
		active_state_next = true
	pass

func _on_body_exit( body ):
	if body.get_groups().has("player"):
		contact.hide()
		contact.set_frame(0)
		
		base.set_frame(0)
		base.play("idle")
		
		active_state_next = false
		contact_count = 0
	pass
