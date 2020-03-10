extends Control


func _ready() -> void:
	if not ProjectSettings.get_setting("Debug/debug_mode"):
		queue_free()
	get_parent().connect("state_changed", self, "_on_State_changed")


func _on_State_changed(state: String) -> void:
	$Label.text = state
