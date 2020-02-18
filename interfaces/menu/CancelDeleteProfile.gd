extends TranslatedButton


func _ready():
	._ready()
	connect('pressed', self, '_on_Pressed')


"""
@signal pressed
"""
func _on_Pressed() -> void:
	get_tree().get_current_scene().get_node("AnimationPlayer").play("ValidationNo")
