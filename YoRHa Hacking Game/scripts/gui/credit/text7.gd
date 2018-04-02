#credit text7
extends Control

### variable
var text1_step = []

### child node
onready var text1 = get_node("text1")

### anim
onready var anim = utils.main_node().get_node("anim")

### start state
var start = false
var start_prev = false
var start_next = false

### count status
var count1 = 0
var count1_stat = false

### sfx
onready var sample_player = utils.main_node().get_node("sample_player")

#export (NodePath) var next_sceneP
#onready var next_scene = get_node(next_sceneP)

var delay = true
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
	
	if delay == false:
		delay_count = 0
	elif delay == true:
		delay_count += 1
		if delay_count == 50:
			count1_stat = true
			delay = false
	
	if count1_stat == true:
		text1.show()
		count1 += ((1.5*delta)*10)
		if count1 < 24:
			text1.set_text(text1_step[count1])
			sample_player.play("type")
		elif count1 > 40:
			get_parent().end_state_next = true
			count1_stat = false
	elif count1_stat == false:
		count1 = 0
	
	pass

func scene_variable():
	text1_step = ["T_", 
				"Th_", 
				"Tha_", 
				"Than_", 
				"Thank_", 
				"Thanks_", 
				"Thanks _", 
				"Thanks F_", 
				"Thanks Fo_",
				"Thanks For_",
				"Thanks For _",
				"Thanks For P_",
				"Thanks For Pl_",
				"Thanks For Pla_",
				"Thanks For Play_",
				"Thanks For Playi_",
				"Thanks For Playin_",
				"Thanks For Playing_",
				"Thanks For Playing _",
				"Thanks For Playing ._",
				"Thanks For Playing . _",
				"Thanks For Playing . ._",
				"Thanks For Playing . . _",
				"Thanks For Playing . . . "]
	pass