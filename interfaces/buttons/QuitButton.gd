# Global quit button action management
extends MenuUIBtn


func _ready() -> void:
	connect("pressed", self, "_on_Quit")


# @signal pressed
func _on_Quit() -> void:
	get_tree().quit()
