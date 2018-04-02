#credit text2
extends Control

### variable
var text1_step = []
var text2_step = []
var text3_step = []
var text4_step = []

### child node
onready var text1 = get_node("text1")
onready var text2 = get_node("text2")
onready var text3 = get_node("text3")
onready var text4 = get_node("text4")

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
var count3 = 0
var count3_stat = false
var count4 = 0
var count4_stat = false

### sfx
onready var sample_player = utils.main_node().get_node("sample_player")

export (NodePath) var next_sceneP
onready var next_scene = get_node(next_sceneP)

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	scene2_variable()
	start_prev = start
	start = start_next
	
	if start == true:
		self.show()
		scene2(delta)
	elif start == false:
		self.hide()
	pass

func scene2(delta):
	if count1_stat == true:
		text1.show()
		count1 += ((1.5*delta)*12.5)
		if count1 < 10:
			text1.set_text(text1_step[count1])
			sample_player.play("type")
		elif count1 > 12:
			count2_stat = true
			count1_stat = false
	elif count1_stat == false:
		count1 = 0
	
	if count2_stat == true:
		text2.show()
		count2 += ((1.5*delta)*12.5)
		if count2 < 14:
			text2.set_text(text2_step[count2])
			sample_player.play("type")
		elif count2 > 16:
			count3_stat = true
			count2_stat = false
	elif count2_stat == false:
		count2 = 0
	
	if count3_stat == true:
		text3.show()
		count3 += ((1.5*delta)*12.5)
		if count3 < 16:
			text3.set_text(text3_step[count3])
			sample_player.play("type")
		elif count3 > 18:
			count4_stat = true
			anim.play("scene2")
			count3_stat = false
	elif count3_stat == false:
		count3 = 0
	
	if count4_stat == true:
		text4.show()
		count4 += ((1.5*delta)*12.5)
		if count4 < 14:
			text4.set_text(text4_step[count4])
			sample_player.play("type")
		elif count4 > 55:
			start_next = false
			self.hide()
			next_scene.start_next = true
			set_fixed_process(false)
			count4_stat = false
	elif count4_stat == false:
		count4 = 0
	pass

func scene2_variable():
	text1_step = ["[P]_", 
				"[P]r_", 
				"[P]ro_", 
				"[P]rog_", 
				"[P]rogr_", 
				"[P]rogra_", 
				"[P]rogram_", 
				"[P]rogramm_", 
				"[P]rogramme_", 
				"[P]rogrammer "]
	text2_step = ["G_",
				"Gr_", 
				"Gra_", 
				"Grap_", 
				"Graph_", 
				"Graphi_", 
				"Graphic_", 
				"Graphic _", 
				"Graphic [R]_", 
				"Graphic [Re]_",
				"Graphic [Re]d_",
				"Graphic [Re]dr_",
				"Graphic [Re]dra_",
				"Graphic [Re]draw "]
	text3_step = ["A_",
				"An_", 
				"Ani_", 
				"Anim_", 
				"Anima_", 
				"Animat_", 
				"Animati_", 
				"Animatio_", 
				"Animation_", 
				"Animation _",
				"Animation [R]_",
				"Animation [Re]_",
				"Animation [Re]d_",
				"Animation [Re]dr_",
				"Animation [Re]dra_",
				"Animation [Re]draw "]
	text4_step = ["A_",
				"Am_", 
				"Amm_", 
				"Amma_", 
				"Ammar_", 
				"Ammar _", 
				"Ammar [Z]_", 
				"Ammar [Z]u_", 
				"Ammar [Z]ul_", 
				"Ammar [Z]ulf_",
				"Ammar [Z]ulfi_",
				"Ammar [Z]ulfik_",
				"Ammar [Z]ulfika_",
				"Ammar [Z]ulfikar "]
	pass