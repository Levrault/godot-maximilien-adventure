"""
Global prev button action management
"""
extends MenuUIBtn


func _ready() -> void:
	connect('pressed', self, '_on_Menu')


"""
@signal pressed
"""
func _on_Menu() -> void:
	SceneManager.goto_scene("res://interfaces/menu/Menu.tscn")
