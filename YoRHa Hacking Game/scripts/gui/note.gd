#note
extends Control

var main_text_array = ["Gate Open . . .",#0
					"Saving . . .",#1
					"New Path Open . . .",#2
					"Level Clear . . .",#3
					"Unknown Status . . .",#4
					"Access Granted . . .",#5
					"Clear"#6
					]
var main_text 
var main_text_backup = ""
var main_text_total = 0
var main_text_node
var main_text_node_path = "label"
var type_stat = false
var type_count = 0
onready var sample_player_warn = get_node("sample_player_warn")

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	typing(delta)
	pass

func typing(delta):
	if type_stat == true:
		main_text_node = get_node(main_text_node_path)
		main_text_node.show()
		type_count += ((1.5*delta)*12.5)
		
		if type_count < main_text_total:
			main_text_node.set_text(main_text.substr(0,type_count)+"_")
		elif type_count > (main_text_total+1):
			main_text_node.set_text(main_text_backup)
			if type_count > (main_text_total+40):
				main_text_node.hide()
				type_stat = false
		
	elif type_stat == false:
		type_count = 0
	pass

func typing_call( array_value ):
	sample_player_warn.play("note")
	main_text = main_text_array[array_value]
	main_text_backup = main_text_array[array_value]
	main_text_total = main_text.length()
	type_stat = true
	pass