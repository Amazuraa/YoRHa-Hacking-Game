#player_hit_area
extends Area2D

var destroyed = false

func _ready():
	pass

func player_hit_area():
	return not destroyed
	pass


