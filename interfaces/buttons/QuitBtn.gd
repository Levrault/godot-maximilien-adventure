# Should quit game on press
extends TranslatedButton


func _ready():
	connect("pressed", self, "_on_Pressed")


# @signal pressed
func _on_Pressed() -> void:
	get_tree().quit()
