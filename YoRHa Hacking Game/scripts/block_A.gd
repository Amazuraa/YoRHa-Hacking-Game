# block_A
# this one will block all type of bullets
extends StaticBody2D

var destroyed = false

func _ready():
	add_to_group("block_A")
	pass

func block_A():
	return not destroyed
	pass