#ending notification
extends Node2D


func _ready():
	pass

func to_main_menu():
	utils.loading_destination = "res://main_menu/main_menu.tscn"
	get_tree().change_scene("res://scenes/gui/loading.tscn")
	pass
