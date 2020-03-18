# Global prev button action management
extends MenuUIBtn


func _ready() -> void:
	connect("pressed", self, "_on_Setting")


# @signal pressed
func _on_Setting() -> void:
	get_parent().queue_free()
	get_tree().change_scene("res://interfaces/settings/Settings.tscn")
