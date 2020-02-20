"""
Should load overworld scene on press
"""
extends TranslatedButton


func _ready():
	._ready()
	connect('pressed', self, '_on_Pressed')


"""
@signal pressed
"""
func _on_Pressed() -> void:
	get_tree().paused = false
	SceneManager.goto_scene("res://interfaces/overworld/OverWorld.tscn")
