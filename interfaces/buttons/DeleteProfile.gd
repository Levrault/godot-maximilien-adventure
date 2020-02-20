"""
Delete profile save file
"""
extends TranslatedButton

func _ready():
	._ready()
	connect('pressed', self, '_on_Pressed')


"""
@signal pressed
"""
func _on_Pressed() -> void:
	ProgressionManager.delete_save_game(get_tree().get_current_scene().selected_profile)
	get_tree().reload_current_scene()
