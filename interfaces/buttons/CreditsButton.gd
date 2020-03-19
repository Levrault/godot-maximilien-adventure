# Global prev button action management
extends MenuUIBtn


func _ready() -> void:
	connect("pressed", self, "_on_Credits")


# @signal pressed
func _on_Credits() -> void:
	get_parent().queue_free()
	get_tree().change_scene("res://interfaces/credits/Credits.tscn")
