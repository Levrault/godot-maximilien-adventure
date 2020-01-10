tool
extends Label
class_name TranslatedLabel

var previous_text:= ""

func _ready():
	text = TranslationServer.translate(text)
	previous_text = text


func _process(delta):
	if Engine.editor_hint:
		if previous_text != text:
			previous_text = text
			text = TranslationServer.translate(text)