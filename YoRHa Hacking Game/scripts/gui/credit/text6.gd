#credit text6
extends Control

### variable
var text1_step = []
var text2_step = []

### child node
onready var text1 = get_node("text1")
onready var text2 = get_node("text2")

### anim
onready var anim = utils.main_node().get_node("anim")

### start state
var start = false
var start_prev = false
var start_next = false

### count status
var count1 = 0
var count1_stat = true
var count2 = 0
var count2_stat = false

### sfx
onready var sample_player = utils.main_node().get_node("sample_player")

export (NodePath) var next_sceneP
onready var next_scene = get_node(next_sceneP)

var delay = false
var delay_count = 0

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	scene_variable()
	start_prev = start
	start = start_next
	
	if start == true:
		self.show()
		scene(delta)
	elif start == false:
		self.hide()
	pass

func scene(delta):
	if count1_stat == true:
		text1.show()
		count1 += ((1.5*delta)*12.5)
		if count1 < 23:
			text1.set_text(text1_step[count1])
			sample_player.play("type")
		elif count1 > 25:
			count2_stat = true
			count1_stat = false
	elif count1_stat == false:
		count1 = 0
	
	if count2_stat == true:
		text2.show()
		count2 += ((1.5*delta)*12.5)
		if count2 < 52:
			text2.set_text(text2_step[count2])
			sample_player.play("type")
		elif count2 > 54:
			anim.play("scene6")
			delay = true
			count2_stat = false
	elif count2_stat == false:
		count2 = 0
	
	if delay == false:
		delay_count = 0
	elif delay == true:
		delay_count += 1
		if delay_count == 178:
			next_scene.start_next = true
			anim.play("scene7")
			start_next = false
			delay = false
	pass

func scene_variable():
	text1_step = ["I_", 
				"If_", 
				"If _", 
				"If y_", 
				"If yo_", 
				"If you_", 
				"If you _", 
				"If you e_", 
				"If you en_",
				"If you enj_",
				"If you enjo_",
				"If you enjoy_",
				"If you enjoy _",
				"If you enjoy t_",
				"If you enjoy th_",
				"If you enjoy thi_",
				"If you enjoy this_",
				"If you enjoy this _",
				"If you enjoy this g_",
				"If you enjoy this ga_",
				"If you enjoy this gam_",
				"If you enjoy this game_",
				"If you enjoy this game, "]
	text2_step = ["P_",
				"Pl_", 
				"Ple_", 
				"Plea_", 
				"Pleas_", 
				"Please_", 
				"Please _", 
				"Please m_", 
				"Please ma_",
				"Please mak_",
				"Please make_",
				"Please make _",
				"Please make s_",
				"Please make su_",
				"Please make sur_",
				"Please make sure_",
				"Please make sure _",
				"Please make sure t_",
				"Please make sure to_",
				"Please make sure to _",
				"Please make sure to P_",
				"Please make sure to Pl_",
				"Please make sure to Pla_",
				"Please make sure to Play_",
				"Please make sure to Play _",
				"Please make sure to Play &_",
				"Please make sure to Play & _",
				"Please make sure to Play & S_",
				"Please make sure to Play & Su_",
				"Please make sure to Play & Sup_",
				"Please make sure to Play & Supp_",
				"Please make sure to Play & Suppo_",
				"Please make sure to Play & Suppor_",
				"Please make sure to Play & Support_",
				"Please make sure to Play & Support _",
				"Please make sure to Play & Support t_",
				"Please make sure to Play & Support th_",
				"Please make sure to Play & Support the_",
				"Please make sure to Play & Support the _",
				"Please make sure to Play & Support the O_",
				"Please make sure to Play & Support the Or_",
				"Please make sure to Play & Support the Ori_",
				"Please make sure to Play & Support the Orig_",
				"Please make sure to Play & Support the Origi_",
				"Please make sure to Play & Support the Origin_",
				"Please make sure to Play & Support the Origina_",
				"Please make sure to Play & Support the Original_",
				"Please make sure to Play & Support the Original _",
				"Please make sure to Play & Support the Original G_",
				"Please make sure to Play & Support the Original Ga_",
				"Please make sure to Play & Support the Original Gam_",
				"Please make sure to Play & Support the Original Game "]
	pass