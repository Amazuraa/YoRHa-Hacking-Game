#credit text5
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
var count1_stat = true

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
		if count1 < 9:
			text1.set_text(text1_step[count1])
			sample_player.play("type")
		elif count1 > 11:
			anim.play("scene5")
			delay = true
			count1_stat = false
	elif count1_stat == false:
		count1 = 0
	
	if delay == false:
		delay_count = 0
	elif delay == true:
		delay_count += 1
		if delay_count == 180:
			next_scene.start_next = true
			start_next = false
			delay = false
	pass

func scene_variable():
	text1_step = ["[M]_", 
				"[M]a_", 
				"[M]ad_", 
				"[M]ade_", 
				"[M]ade _", 
				"[M]ade W_", 
				"[M]ade Wi_", 
				"[M]ade Wit_", 
				"[M]ade With "]
	pass