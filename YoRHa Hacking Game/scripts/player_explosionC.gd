extends AnimatedSprite

var player
export var death_scn_delay = 5
var count = 0

func _ready():
	set_fixed_process(true)
	pass

func _on_finished():
	pass

func _fixed_process(delta):
	if get_frame() >= 49:
		count += 1
		if count == death_scn_delay:
			get_tree().change_scene("res://scenes/gui/death_gui_delete.tscn")
			queue_free()
	pass