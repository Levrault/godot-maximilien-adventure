"""
Main Menu
"""
extends Control


func _ready() -> void:
	$MenuVBoxContainer/Start.connect('pressed', self, '_on_Start_pressed')


"""
Start button.

@signal pressed
"""
func _on_Start_pressed() -> void:
	get_tree().change_scene("res://interfaces/overworld/OverWorld.tscn")
