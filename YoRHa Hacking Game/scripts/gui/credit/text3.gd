#credit text3
extends Control

### variable
var text1_step = []
var text2_step = []
var dec_step   = []

### child node
onready var text1 = get_node("text1")
onready var text2 = get_node("text2")
onready var dec = get_node("dec")

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
var dec_count = 0
var dec_count_stat = false

### sfx
onready var sample_player = utils.main_node().get_node("sample_player")

export (NodePath) var next_nodeP
onready var next_node = get_node(next_nodeP)

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
		if count1 < 12:
			text1.set_text(text1_step[count1])
			sample_player.play("type")
		elif count1 > 14:
			dec_count_stat = true
			count1_stat = false
	elif count1_stat == false:
		count1 = 0
	
	if dec_count_stat == true:
		dec.show()
		dec_count += ((1.5*delta)*12.5)
		if dec_count < 14:
			dec.set_text(dec_step[dec_count])
			sample_player.play("type")
		elif dec_count > 16:
			count2_stat = true
			anim.play("scene3")
			dec_count_stat = false
	elif dec_count_stat == false:
		dec_count = 0
	
	if count2_stat == true:
		text2.show()
		count2 += ((1.5*delta)*12.5)
		if count2 < 8:
			text2.set_text(text2_step[count2])
			sample_player.play("type")
		elif count2 > 57:
			next_node.start_next = true
			start_next = false
			count2_stat = false
	elif count2_stat == false:
		count2 = 0
	
	pass

func scene2_variable():
	text1_step = ["[G]_", 
				"[G]a_", 
				"[G]am_", 
				"[G]ame_", 
				"[G]ame _", 
				"[G]ame C_", 
				"[G]ame Co_", 
				"[G]ame Con_", 
				"[G]ame Conc_", 
				"[G]ame Conce_",
				"[G]ame Concep_",
				"[G]ame Concept "]
	text2_step = ["B_",
				"Ba_", 
				"Bas_", 
				"Base_", 
				"Based_", 
				"Based _", 
				"Based O_", 
				"Based On "]
	dec_step = ["_", 
				"__", 
				"____", 
				"______", 
				"________", 
				"___________", 
				"______________", 
				"_________________",
				"____________________",
				"_______________________",
				"__________________________",
				"_____________________________",
				"________________________________",
				"__________________________________"]
	pass