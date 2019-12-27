"""
Translate text
"""
extends Label


func _ready():
	text = TranslationServer.translate(text)