#scene saver
extends Node2D

### import the input helper class
var input_states = preload("input_states.gd")

### animation sprites
onready var contact = get_node("contact")
onready var base = get_node("base")
onready var contact_loading = get_node("contact_loading")

onready var area = get_node("area")

var active_state = false
var active_state_prev = false
var active_state_next = false

var contact_button_setting = input_states.new("contact")
var contact_button = null
var contact_count = 0

export var hidden = true  

export var limit = 1000
var limit_count = 0

onready var hint = get_node("hint")

func _ready():
	area.connect("body_enter", self, "_on_body_enter")
	area.connect("body_exit", self, "_on_body_exit")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	active_state_prev = active_state
	active_state = active_state_next
	
	if hidden == true:
		self.hide()
		active_state_next = false
	elif hidden == false:
		self.show()
		limit_count += 1
		active_state_next = true
		if limit_count == limit:
			self.queue_free()
	
	contact_button = contact_button_setting.check()
	
	if contact.get_frame() >= 14:
		contact.hide()
	
	if active_state == true:
		if contact_button == 2 :
			contact_count += 1
			if contact_count == 49 :
				save_scene()
				
			contact_loading.set_frame(contact_count)
		
		elif contact_button == 0 :
			contact_count = 0
			contact_loading.set_frame(contact_count)
		
	elif active_state == false:
		return
	
	pass

func save_scene():
	hidden = true
	utils.main_node().get_node("CanvasLayer/note").typing_call(1)
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save(utils.scene_saver_path, packed_scene)
	queue_free()
	pass

func _on_body_enter( body ):
	if body.get_name() == "player":
		hint.show()
		
		contact.show()
		contact.set_frame(0)
		contact.play("contact")
		
		base.set_frame(0)
		base.play("touched")
		
		active_state_next = true
		limit_count = 0
	pass

func _on_body_exit( body ):
	if body.get_name() == "player":
		hint.hide()
		
		contact.hide()
		contact.set_frame(0)
		
		base.set_frame(0)
		base.play("idle")
		
		active_state_next = false
		contact_count = 0
	pass