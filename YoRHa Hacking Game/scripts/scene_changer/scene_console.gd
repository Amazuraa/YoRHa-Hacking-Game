#scene console
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

export var hidden = false  

onready var stream_player = get_node("stream_player")

onready var console = utils.main_node().get_node("CanvasLayer/console")

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	active_state_prev = active_state
	active_state = active_state_next
	
	if hidden == true:
		self.hide()
	elif hidden == false:
		self.show()
	
	if contact.get_frame() >= 14:
		contact.hide()
	
	if active_state == true:
		contact_button = contact_button_setting.check()
		if contact_button == 2 :
			contact_count += 1
			if contact_count == 35 :
				stream_player.play("contact")
			if contact_count == 49 :
				console.hidden = false
				active_state_next = false
				
			contact_loading.set_frame(contact_count)
		
		elif contact_button == 0 :
			contact_count = 0
			contact_loading.set_frame(contact_count)
		
	elif active_state == false:
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
