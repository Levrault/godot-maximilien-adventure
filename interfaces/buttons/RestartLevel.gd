"""
Should reload level
"""
extends Button


func _ready():
	connect('pressed', self, '_on_Pressed')
	text = TranslationServer.translate(text)


"""
@signal pressed
"""
func _on_Pressed() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false