# death gui
# appear when player death
extends Control

onready var button_y_anim = get_node("CanvasLayer/button_yes/button")
onready var button_n_anim = get_node("CanvasLayer/button_no/button")
onready var text_y = get_node("CanvasLayer/button_yes/text")
onready var text_n = get_node("CanvasLayer/button_no/text")

onready var arrow = get_node("CanvasLayer/arrow")
var index = 0

onready var text1 = get_node("text_container/text1")
onready var text2 = get_node("text_container/text2")
onready var text3 = get_node("text_container/text3")
onready var text4 = get_node("text_container/text4")
onready var text5 = get_node("text_container/text5")
onready var text6 = get_node("text_container/text6")
onready var text7 = get_node("text_container/text7")
onready var text8 = get_node("text_container/text8")

var text_random
var decision_yes = ""
var decision_no = ""

onready var sample_player = get_node("sample_player")
var enter_count = 0
export var enter_delay = 10
var enter_state = false
var enter_state_prev = false
var enter_state_next = false

### typing process
onready var sample_player_type = get_node("sample_player_type")
var main_text = ""
var main_text_backup = ""
var main_text_total = 0
var main_text_node
var main_text_node_path = ""
var type_stat = false
var type_count = 0

func _ready():
	global_bgm.death_state_next = true
	set_process_input(true)
	set_fixed_process(true)
	randomize()
	text_random = range(1,9) [randi()%range(1,9).size()] 
	text()
	pass

func _fixed_process(delta):
	enter_state_prev = enter_state
	enter_state = enter_state_next
	enter_start_count()
	typing(delta)
	pass

func _input(event):
	if event.is_action("ui_up") && event.is_pressed() && !event.is_echo():
		if(index != 0):
			index -= 1
			
			button_y_anim.play("selected")
			button_n_anim.play("reverse")
			
			sample_player.play("button_select")
			
			var x = arrow.get_pos().x
			var y = arrow.get_pos().y - 45
			arrow.set_pos(Vector2(x,y))
			
			text_y.add_color_override("font_color", Color("#bfbfbf"))
			text_n.add_color_override("font_color", Color("#555148"))
	
	elif event.is_action("ui_down") && event.is_pressed() && !event.is_echo():
		if(index != 1):
			index += 1
			
			button_y_anim.play("reverse")
			button_n_anim.play("selected")
			
			sample_player.play("button_select")
			
			var x = arrow.get_pos().x
			var y = arrow.get_pos().y + 45
			arrow.set_pos(Vector2(x,y))
			
			text_y.add_color_override("font_color", Color("#555148"))
			text_n.add_color_override("font_color", Color("#bfbfbf"))
	
	elif event.is_action("enter") && event.is_pressed() && !event.is_echo():
		if (index == 0):
			sample_player.play("button_enter")
			yes(decision_yes)
		elif (index == 1):
			sample_player.play("button_enter")
			no(decision_no)
	pass

func text():
	if text_random == 1:
		main_text_node_path = "text_container/text1"
		main_text = "Are you give up here?"
		main_text_backup = "Are you give up here?"
		main_text_total = main_text.length()
		type_stat = true
		
		decision_yes = "giveup"
		decision_no  = "continue"
		
	elif text_random == 2:
		main_text_node_path = "text_container/text2"
		main_text = "Is this level to hard for you?"
		main_text_backup = "Is this level to hard for you?"
		main_text_total = main_text.length()
		type_stat = true
		
		decision_yes = "giveup"
		decision_no  = "continue"
		
	elif text_random == 3:
		main_text_node_path = "text_container/text3"
		main_text = "Do you admit to lose?"
		main_text_backup = "Do you admit to lose?"
		main_text_total = main_text.length()
		type_stat = true
		
		decision_yes = "giveup"
		decision_no  = "continue"
		
	elif text_random == 4:
		main_text_node_path = "text_container/text4"
		main_text = "Give up in this meaningless battle?"
		main_text_backup = "Give up in this meaningless battle?"
		main_text_total = main_text.length()
		type_stat = true
		
		decision_yes = "giveup"
		decision_no  = "continue"
		
	elif text_random == 5:
		main_text_node_path = "text_container/text5"
		main_text = "Do you accept defeat?"
		main_text_backup = "Do you accept defeat?"
		main_text_total = main_text.length()
		type_stat = true
		
		decision_yes = "giveup"
		decision_no  = "continue"
		
	elif text_random == 6:
		main_text_node_path = "text_container/text6"
		main_text = "Do you think you can win this game?"
		main_text_backup = "Do you think you can win this game?"
		main_text_total = main_text.length()
		type_stat = true
		
		decision_yes = "continue"
		decision_no  = "giveup"
		
	elif text_random == 7:
		main_text_node_path = "text_container/text7"
		main_text = "Still want to continue?"
		main_text_backup = "Still want to continue?"
		main_text_total = main_text.length()
		type_stat = true
		
		decision_yes = "continue"
		decision_no  = "giveup"
		
	elif text_random == 8:
		main_text_node_path = "text_container/text8"
		main_text = "Don't you think the enemies are\nStrong enough for you?"
		main_text_backup = "Don't you think the enemies are\nStrong enough for you?"
		main_text_total = main_text.length()
		type_stat = true
		
		decision_yes = "continue"
		decision_no  = "continue"
	pass

func typing(delta):
	if type_stat == true:
		main_text_node = get_node(main_text_node_path)
		main_text_node.show()
		type_count += ((1.5*delta)*12.5)
		
		if type_count < main_text_total: 
			main_text_node.set_text(main_text.substr(0,type_count)+"_")
			sample_player_type.play("type")
		elif type_count > (main_text_total+1):
			main_text_node.set_text(main_text_backup)
			type_stat = false
		
	elif type_stat == false:
		type_count = 0
	pass

func yes(decision):
	if decision == "continue":
		if utils.debug_death == true:
			get_tree().change_scene("res://levels/debug.tscn")
		elif utils.debug_death == false:
			get_tree().change_scene(utils.scene_saver_path)
		
	elif decision == "giveup":
		if global_bgm.music_player.is_playing() == true:
			global_bgm.music_level = "last"
		enter_state_next = true
	pass

func no(decision):
	if decision == "continue":
		if utils.debug_death == true:
			get_tree().change_scene("res://levels/debug.tscn")
		elif utils.debug_death == false:
			get_tree().change_scene(utils.scene_saver_path)
		
	elif decision == "giveup":
		if global_bgm.music_player.is_playing() == true:
			global_bgm.music_level = "last"
		enter_state_next = true
	pass

func enter_start_count():
	if enter_state == true:
		enter_count += 1
		if enter_count == enter_delay:
			var dir = Directory.new()
			utils.loading_destination = "res://main_menu/main_menu.tscn"
			get_tree().change_scene("res://scenes/gui/loading_respawn.tscn")
			dir.remove(utils.scene_saver_path)
	elif enter_state == false:
		enter_count = 0
	pass