"""
Should load settings scene on press
"""
extends Button


func _ready():
	connect('pressed', self, '_on_Pressed')
	text = TranslationServer.translate(text)


"""
@signal pressed
"""
func _on_Pressed() -> void:
	print("settings")
