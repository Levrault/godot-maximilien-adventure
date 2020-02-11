"""
Main Menu
"""
extends Control


func _ready() -> void:
	pass

"""
Start button.

@signal pressed
"""
func _on_Start_pressed() -> void:
	get_tree().change_scene("res://interfaces/overworld/OverWorld.tscn")
