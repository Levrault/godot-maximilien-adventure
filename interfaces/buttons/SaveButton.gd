# Global prev button action management
extends MenuUIBtn


func _ready() -> void:
	connect("pressed", self, "_on_Menu")


# @signal pressed
func _on_Menu() -> void:
	get_parent().queue_free()
	get_tree().change_scene("res://interfaces/menu/Menu.tscn")
