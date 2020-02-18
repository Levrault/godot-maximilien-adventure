"""
Button with translation
"""
extends Button
class_name TranslatedButton

func _ready():
	text = TranslationServer.translate(text)
