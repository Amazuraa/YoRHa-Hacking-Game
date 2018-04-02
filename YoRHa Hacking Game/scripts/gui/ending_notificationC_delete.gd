#ending notification C_delete
extends Node2D


func _ready():
	utils.remove_save()
	pass

func to_main_menu():
	get_tree().change_scene("res://scenes/gui/opening_main.tscn")
	pass
