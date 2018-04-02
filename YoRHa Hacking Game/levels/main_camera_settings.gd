#main camera settings
#zooming in certain area
extends Area2D

export (NodePath) var camera_path
onready var camera = get_node(camera_path)

export var set_zoom = Vector2()
var zooming = Vector2() 
var num 

var x_prev

func _ready():
	self.connect("body_enter", self, "_on_body_enter")
	self.connect("body_exit", self, "_on_body_exit")
	pass

func _fixed_process(delta):
	
	if x_prev.x < set_zoom.x:
		if num < set_zoom.x:
			num += 0.01
			zooming = Vector2(num, num)
		else:
			utils.zoom_prev = set_zoom
	elif x_prev.x > set_zoom.x:
		if num > set_zoom.x:
			num -= 0.01
			zooming = Vector2(num, num)
		else:
			utils.zoom_prev = set_zoom
	elif x_prev.x == set_zoom.x:
		zooming = Vector2(set_zoom)
	
	camera.set_zoom(zooming)
	pass

func _on_body_enter( body ):
	if body.get_groups().has("player"):
		x_prev = utils.zoom_prev
		num = x_prev.x
		set_fixed_process(true)
		pass
	pass

func _on_body_exit( body ):
	if body.get_groups().has("player"):
		set_fixed_process(false)
	pass