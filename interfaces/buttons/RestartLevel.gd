# Should reload level
extends TranslatedButton


func _ready():
	connect("pressed", self, "_on_Pressed")


# @signal pressed
func _on_Pressed() -> void:
	get_tree().paused = false
	assert(SceneManager.scene_path)
	SceneManager.goto_scene(SceneManager.scene_path)
