# block_C
# the player will be hit if colide with this block

extends Area2D

func _ready():
	self.connect("body_enter", self, "_on_body_enter")
	pass

func _on_body_enter( body ):
	if body.get_groups().has("player"):
		body.hit()
	pass

