extends Label
class_name TranslatedLabel

func _ready():
	text = TranslationServer.translate(text)
