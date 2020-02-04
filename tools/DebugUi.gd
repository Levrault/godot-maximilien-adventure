extends CanvasLayer


func _ready():
	if not ProjectSettings.get_setting("Debug/debug_mode"):
		queue_free()
